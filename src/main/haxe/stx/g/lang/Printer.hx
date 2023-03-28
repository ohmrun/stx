/*
 * Copyright (C)2005-2019 Haxe Foundation
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 */

 package stx.g.lang;

 using stx.g.Lang;
 using StringTools;
 using stx.g.lang.Printer;

 /**
   This class provides some utility methods to convert elements from the
   macro context to a human-readable String representation.
  */
 class Printer {
   static public function iter<T>(iter:Cluster<T>,fn:T->Void){
     for(x in iter){
       fn(x);
     }
   }
   static public var ZERO(get,null) : Printer;
   static function get_ZERO(){
     return ZERO == null ? ZERO = new Printer() : ZERO;
   }
   var tabs:String;
   var tabString:String;
 
   public function new(?tabString = "\t") {
     tabs = "";
     this.tabString = tabString;
   }
 
   public function printUnop(op:GUnop)
     return switch (op) {
       case GOpIncrement: "++";
       case GOpDecrement: "--";
       case GOpNot: "!";
       case GOpNeg: "-";
       case GOpNegBits: "~";
       case GOpSpread: "...";
     }
 
   public function printBinop(op:GBinop)
     return switch (op) {
       case GOpAdd: "+";
       case GOpMult: "*";
       case GOpDiv: "/";
       case GOpSub: "-";
       case GOpAssign: "=";
       case GOpEq: "==";
       case GOpNotEq: "!=";
       case GOpGt: ">";
       case GOpGte: ">=";
       case GOpLt: "<";
       case GOpLte: "<=";
       case GOpAnd: "&";
       case GOpOr: "|";
       case GOpXor: "^";
       case GOpBoolAnd: "&&";
       case GOpBoolOr: "||";
       case GOpShl: "<<";
       case GOpShr: ">>";
       case GOpUShr: ">>>";
       case GOpMod: "%";
       case GOpInterval: "...";
       case GOpArrow: "=>";
       case GOpIn: "in";
       #if (haxe_ver > 4.205)
       case GOpNullCoal: "??";
       #end
       case GOpAssignOp(op):
         printBinop(op) + "=";
     }
 
   function escapeString(s:String, delim:String) {
     return delim
       + s.replace('\\', '\\\\')
         .replace("\n", "\\n")
         .replace("\t", "\\t")
         .replace("\r", "\\r")
         .replace("'", "\\'")
         .replace('"', "\\\"") #if sys .replace("\x00", "\\x00") #end + delim;
   }
 
   public function printFormatString(s:String) {
     return escapeString(s, "'");
   }
 
   public function printString(s:String) {
     return escapeString(s, '"');
   }
 
   public function printConstant(c:GConstant)
     return switch (c) {
       case GCString(s, GSingleQuotes): printFormatString(s);
       case GCString(s, _): printString(s);
       case GCIdent(s), GCInt(s, null), GCFloat(s, null):
         s;
       case GCInt(s, suffix), GCFloat(s, suffix):
         s + suffix;
       case GCRegexp(s, opt): '~/$s/$opt';
     }
 
   public function printTypeParam(param:GTypeParam)
     return switch (param) {
       case GTPType(ct): printComplexType(ct);
       case GTPExpr(e): printExpr(e);
     }
 
   public function printTypePath(tp:GTypePath)
     return (tp.pack.length > 0 ? tp.pack.join(".") + "." : "")
       + tp.name
       + (tp.sub != null ? '.${tp.sub}' : "")
       + (tp.params == null ? "" : tp.params.length > 0 ? "<" + tp.params.map(printTypeParam).join(", ") + ">" : "");
 
   // TODO: check if this can cause loops
   public function printComplexType(ct:GComplexType):String
     return switch (ct) {
       case GTPath(tp): printTypePath(tp);
       case GTFunction(args, ret):
         var wrapArgumentsInParentheses = switch args {
           // type `:(a:X) -> Y` has args as [TParent(TNamed(...))], i.e `a:X` gets wrapped in `TParent()`. We don't add parentheses to avoid printing `:((a:X)) -> Y`
           case [GTParent(t)]: false;
           // this case catches a single argument that's a type-path, so that `X -> Y` prints `X -> Y` not `(X) -> Y`
           case [GTPath(_) | GTOptional(GTPath(_))]: false;
           default: true;
         }
         var argStr = args.map(printComplexType).join(", ");
         (wrapArgumentsInParentheses ? '($argStr)' : argStr) + " -> " + (switch ret {
           // wrap return type in parentheses if it's also a function
           case GTFunction(_): '(${printComplexType(ret)})';
           default: (printComplexType(ret): String);
         });
       case GTAnonymous(fields): "{ " + [for (f in fields) printField(f) + "; "].join("") + "}";
       case GTParent(ct): "(" + printComplexType(ct) + ")";
       case GTOptional(ct): "?" + printComplexType(ct);
       case GTNamed(n, ct): n + ":" + printComplexType(ct);
       case GTExtend(tpl, fields):
         var types = [for (t in tpl) "> " + printTypePath(t) + ", "].join("");
         var fields = [for (f in fields) printField(f) + "; "].join("");
         '{${types}${fields}}';
       case GTIntersection(tl): tl.map(printComplexType).join(" & ");
     }
 
   public function printMetadata(meta:GMetadataEntry)
     return '@${meta.name}' + ((meta.params != null && meta.params.length > 0) ? '(${printExprs(meta.params, ", ")})' : "");
 
   public function printAccess(access:GAccess)
     return switch (access) {
       case GAStatic: "static";
       case GAPublic: "public";
       case GAPrivate: "private";
       case GAOverride: "override";
       case GAInline: "inline";
       case GADynamic: "dynamic";
       case GAMacro: "macro";
       case GAFinal: "final";
       case GAExtern: "extern";
       case GAAbstract: "abstract";
       case GAOverload: "overload";
     }
 
   public function printField(field:GField) {
     inline function orderAccess(access: Cluster<GAccess>) {
       // final should always be printed last
       // (does not modify input array)
       return access.has(GAFinal).is_defined() ? access.filter(a -> switch(a){ case GAFinal : false; default : true; }).concat([GAFinal]) : access;
     }
     return (field.doc != null
       && field.doc != "" ? "/**\n"
         + tabs
         + tabString
         + StringTools.replace(field.doc, "\n", "\n" + tabs + tabString)
         + "\n"
         + tabs
         + "**/\n"
         + tabs : "")
       + (field.meta != null && field.meta.length > 0 ? field.meta.map(printMetadata).join('\n$tabs') + '\n$tabs' : "")
       + (field.access != null && field.access.length > 0 ? orderAccess(field.access).map(printAccess).join(" ") + " " : "")
       +  switch (field.kind) {
            case GFVar(t, eo): ((field.access != null && field.access.has(GAFinal).is_defined()) ? '' : 'var ') + '${field.name}' + opt(t, printComplexType, " : ") + opt(eo, printExpr, " = ");
            case GFProp(get, set, t, eo): 'var ${field.name}(${get.getting()}, ${set.setting()})' + opt(t, printComplexType, " : ") + opt(eo, printExpr, " = ");
            case GFFun(func): 'function ${field.name}' + printFunction(func);
        }
   }
 
   public function printTypeParamDecl(tpd:GTypeParamDecl)
      return (tpd.meta != null && tpd.meta.length > 0 ? tpd.meta.map(printMetadata).join(" ") + " " : "")
       + tpd.name
       + (tpd.params != null && tpd.params.length > 0 ? "<" + tpd.params.map(printTypeParamDecl).join(", ") + ">" : "")
       + (tpd.constraints != null && tpd.constraints.length > 0 ? ":(" + tpd.constraints.map(printComplexType).join(", ") + ")" : "")
       + (tpd.defaultType != null ? "=" + printComplexType(tpd.defaultType) : "");
 
   public function printFunctionArg(arg:GFunctionArg){
    function opt<T>(v:T, f:T->String, prefix = "") { return v == null ? "" : (prefix + f(v)); }

     return (arg.opt ? "?" : "") + arg.name + opt(arg.type, printComplexType, ":") + opt(arg.value, printExpr, " = ");
   }
  public function printFunction(func:GFunction, ?kind:GFunctionKind) {
    @:privateAccess var skipParentheses = switch func.args {
       case [{ type:null }]: kind == GFArrow;
       case _: false;
     }
     return (func.params == null ? "" : func.params.length > 0 ? "<" + func.params.map(printTypeParamDecl).join(", ") + ">" : "")
       + (skipParentheses ? "" : "(")
       + func.args.map(printFunctionArg).join(", ")
       + (skipParentheses ? "" : ")")
       + (kind == GFArrow ? " ->" : "")
       + opt(func.ret, printComplexType, ":")
       + opt(func.expr, printExpr, " ");
   }
 
   public function printVar(v:GVar) {
    function opt<T>(v:T, f:T->String, prefix = "")
      return v == null ? "" : (prefix + f(v));
  
     var s = v.name + opt(v.type, printComplexType, ":") + opt(v.expr, printExpr, " = ");
     return switch (__.option(v.meta).map(x -> x.prj()).defv(null)) {
       case null|[]: s;
       case meta: meta.map(printMetadata).join(" ") + " " + s;
     }
   }
 
   public function printObjectFieldKey(of:GObjectField) {
     return switch (of.quotes) {
       case null | GUnquoted: of.field;
       case GQuoted: '"${of.field}"'; // TODO: Have to escape that?
     }
   }
 
   public function printObjectField(of:GObjectField) {
     return '${printObjectFieldKey(of)} : ${printExpr(of.expr)}';
   }
 
   public function printExpr(e:GExpr)
     return e == null ? "#NULL" : @:privateAccess switch (e) {
       case GEConst(c): printConstant(c);
       case GEArray(e1, e2): '${printExpr(e1)}[${printExpr(e2)}]';
       case GEBinop(op, e1, e2): '${printExpr(e1)} ${printBinop(op)} ${printExpr(e2)}';
       case GEField(e1, n): '${printExpr(e1)}.$n';
       case GEParenthesis(e1): '(${printExpr(e1)})';
       case GEObjectDecl(fl):
         "{ " + fl.map(function(fld) return printObjectField(fld)).join(", ") + " }";
       case GEArrayDecl(el): '[${printExprs(el, ", ")}]';
       case GECall(e1, el): '${printExpr(e1)}(${printExprs(el, ", ")})';
       case GENew(tp, el): 'new ${printTypePath(tp)}(${printExprs(el, ", ")})';
       case GEUnop(op, true, e1): printExpr(e1) + printUnop(op);
       case GEUnop(op, false, e1): printUnop(op) + printExpr(e1);
       case GEFunction(GFNamed(no,inlined), func): (inlined ? 'inline ' : '') + 'function $no' + printFunction(func);
       case GEFunction(kind, func): (kind != GFArrow ? "function" : "") + printFunction(func, kind);
       case GEVars([]): "var ";
       case GEVars(vl): ((vl[0].isStatic) ? "static " : "") + ((vl[0].isFinal) ? "final " : "var ") + vl.map(printVar).join(", ");
       case GEBlock([]): '{ }';
       case GEBlock(el):
         var old = tabs;
         tabs += tabString;
         var s = '{\n$tabs' + printExprs(el, ';\n$tabs');
         tabs = old;
         s + ';\n$tabs}';
       case GEFor(e1, e2): 'for (${printExpr(e1)}) ${printExpr(e2)}';
       case GEIf(econd, eif, null): 'if (${printExpr(econd)}) ${printExpr(eif)}';
       case GEIf(econd, eif, eelse): 'if (${printExpr(econd)}) ${printExpr(eif)} else ${printExpr(eelse)}';
       case GEWhile(econd, e1, true): 'while (${printExpr(econd)}) ${printExpr(e1)}';
       case GEWhile(econd, e1, false): 'do ${printExpr(e1)} while (${printExpr(econd)})';
       case GESwitch(e1, cl, edef):
         var old = tabs;
         tabs += tabString;
         var s = 'switch ${printExpr(e1)} {\n$tabs'
           + cl.map(function(c) return 'case ${printExprs(c.values, ", ")}' + (c.guard != null ? ' if (${printExpr(c.guard)}):' : ":")
             + (c.expr != null ? (opt(c.expr, printExpr)) + ";" : ""))
             .join('\n$tabs');
         if (edef != null)
           s += '\n${tabs}default:' + (edef == null ? "" : printExpr(edef) + ";");
         tabs = old;
         s + '\n$tabs}';
       case GETry(e1, cl):
         'try ${printExpr(e1)}' + cl.map(function(c) return printCatch(c)).join("");
       case GEReturn(eo): "return" + opt(eo, printExpr, " ");
       case GEBreak: "break";
       case GEContinue: "continue";
       case GEUntyped(e1): "untyped " + printExpr(e1);
       case GEThrow(e1): "throw " + printExpr(e1);
       case GECast(e1, cto) if (cto != null): 'cast(${printExpr(e1)}, ${printComplexType(cto)})';
       case GECast(e1, _): "cast " + printExpr(e1);
       case GEIs(e1, ct): '${printExpr(e1)} is ${printComplexType(ct)}';
       case GETernary(econd, eif, eelse): '${printExpr(econd)} ? ${printExpr(eif)} : ${printExpr(eelse)}';
       case GECheckType(e1, ct): '(${printExpr(e1)} : ${printComplexType(ct)})';
       case GEMeta({ name:":implicitReturn" }, GEReturn(e1) ): printExpr(e1);
       case GEMeta(meta, e1):  printMetadata(meta) + " " + printExpr(e1);
     }
 
   public function printExprs(el:Cluster<GExpr>, sep:String) {
     return el.map(printExpr).join(sep);
   }
 
   function printExtension(tpl:Cluster<GTypePath>, fields:Cluster<GField>) {
     return '{\n$tabs>'
       + tpl.map(printTypePath).join(',\n$tabs>')
       + ","
       + (fields.length > 0 ? ('\n$tabs' + fields.map(printField).join(';\n$tabs') + ";\n}") : ("\n}"));
   }
 
   function printStructure(fields:Cluster<GField>) {
     return fields.length == 0 ? "{ }" : '{\n$tabs' + fields.map(printField).join(';\n$tabs') + ";\n}";
   }
 
   public function printTypeDefinition(t:GTypeDefinition, printPackage = true):String {
     var old = tabs;
     tabs = tabString;
 
     var str = t == null ? "#NULL" : (printPackage && t.pack.length > 0 && t.pack[0] != "" ? "package " + t.pack.join(".") + ";\n" : "")
       + (t.doc != null && t.doc != "" ? "/**\n" + tabString + StringTools.replace(t.doc, "\n", "\n" + tabString) + "\n**/\n" : "")
       + (t.meta != null && t.meta.length > 0 ? t.meta.map(printMetadata).join(" ") + " " : "")
       + (t.isExtern ? "extern " : "")
       + switch (t.kind) {
         case GTDEnum:
           "enum "
           + t.name
           + ((t.params != null && t.params.length > 0) ? "<" + t.params.map(printTypeParamDecl).join(", ") + ">" : "")
           + " {\n"
           + [
             for (field in t.fields)
               tabs
               + (field.doc != null
                 && field.doc != "" ? "/**\n"
                   + tabs
                   + tabString
                   + StringTools.replace(field.doc, "\n", "\n" + tabs + tabString)
                   + "\n"
                   + tabs
                   + "**/\n"
                   + tabs : "")
               + (field.meta != null && field.meta.length > 0 ? field.meta.map(printMetadata).join(" ") + " " : "")
               + (switch (field.kind) {
                 case GFVar(t, _): field.name + opt(t, printComplexType, ":");
                 case GFProp(_, _, _, _): throw "FProp is invalid for TDEnum.";
                 case GFFun(func): field.name + printFunction(func);
               })
               + ";"].join("\n")
           + "\n}";
         case GTDStructure:
           "typedef "
           + t.name
           + ((t.params != null && t.params.length > 0) ? "<" + t.params.map(printTypeParamDecl).join(", ") + ">" : "")
           + " = {\n"
           + [
             for (f in t.fields) {
               tabs + printField(f) + ";";
             }
           ].join("\n")
           + "\n}";
         case GTDClass(superClass, interfaces, isInterface, isFinal, isAbstract):
           (isFinal ? "final " : "")
             + (isAbstract ? "abstract " : "")
             + (isInterface ? "interface " : "class ")
             + t.name
             + (t.params != null && t.params.length > 0 ? "<" + t.params.map(printTypeParamDecl).join(", ") + ">" : "")
             + (superClass != null ? " extends " + printTypePath(superClass) : "")
             + (interfaces != null ? (isInterface ? [for (tp in interfaces) " extends " + printTypePath(tp)] : [
               for (tp in interfaces)
                 " implements " + printTypePath(tp)
             ]).join("") : "")
             + " {\n"
             + [
               for (f in t.fields) {
                 tabs + printFieldWithDelimiter(f);
               }
             ].join("\n")
             + "\n}";
         case GTDAlias(ct):
           "typedef "
           + t.name
           + ((t.params != null && t.params.length > 0) ? "<" + t.params.map(printTypeParamDecl).join(", ") + ">" : "")
           + " = "
           + (switch (ct) {
             case GTExtend(tpl, fields): printExtension(tpl, fields);
             case GTAnonymous(fields): printStructure(fields);
             case _: printComplexType(ct);
           })
           + ";";
         case GTDAbstract(tthis, from, to):
           "abstract "
           + t.name
           + ((t.params != null && t.params.length > 0) ? "<" + t.params.map(printTypeParamDecl).join(", ") + ">" : "")
           + (tthis == null ? "" : "(" + printComplexType(tthis) + ")")
           + (from == null ? "" : [for (f in from) " from " + printComplexType(f)].join(""))
           + (to == null ? "" : [for (t in to) " to " + printComplexType(t)].join(""))
           + " {\n"
           + [
             for (f in t.fields) {
               tabs + printFieldWithDelimiter(f);
             }
           ].join("\n")
           + "\n}";
         case GTDField(kind, access):
           tabs = old;
           (access != null && access.length > 0 ? access.map(printAccess).join(" ") + " " : "")
           + switch (kind) {
             case GFVar(type, eo): ((access != null && access.has(GAFinal).is_defined()) ? '' : 'var ') + '${t.name}' + opt(type, printComplexType, " : ") + opt(eo, printExpr, " = ") + ";";
             case GFProp(get, set, type, eo): 'var ${t.name}(${get.getting()}, ${set.setting()})' + opt(type, printComplexType, " : ") + opt(eo, printExpr, " = ") + ";";
             case GFFun(func): 'function ${t.name}' + printFunction(func) + switch func.expr { case GEBlock(_) : ""; case _: ";"; };
           }
       } tabs = old;
 
     return str;
   }
 
   function printFieldWithDelimiter(f:GField):String {
     return printField(f) + @:privateAccess switch (f.kind) {
       case GFVar(_, _), GFProp(_, _, _, _): ";";
       case GFFun({expr: null}): ";";
       case GFFun({ expr : GEBlock(_) }): "";
       case GFFun(_):  ";";
       case _: "";
     };
   }
   public function printCatch(c:GCatch){
    return ' catch(${c.name}${c.type == null ? '' : (':' + printComplexType(c.type))}) ${printExpr(c.expr)}';
   }
   function opt<T>(v:T, f:T->String, prefix = "")
     return v == null ? "" : (prefix + f(v));
 }
 