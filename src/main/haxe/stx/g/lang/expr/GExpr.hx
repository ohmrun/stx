package stx.g.lang.expr;

enum GExprSum{
  GEConst(c:GConstant);
  GEArray(e1:GExpr, e2:GExpr);
  GEBinop(op:GBinop, e1:GExpr, e2:GExpr);
  GEField(e:GExpr, field:String #if (haxe_ver > 4.205), ?kind:GEFieldKind #end);
  GEParenthesis(e:GExpr);
  GEObjectDecl(fields:Cluster<GObjectField>);
  GEArrayDecl(values:Cluster<GExpr>);
  GECall(e:GExpr, params:Cluster<GExpr>);
  GENew(t:GTypePath, params:Cluster<GExpr>);
  GEUnop(op:GUnop, postFix:Bool, e:GExpr);
  GEVars(vars:Cluster<GVar>);
  GEFunction(kind:Null<GFunctionKind>, f:GFunction);
  GEBlock(exprs:Cluster<GExpr>);
  GEFor(it:GExpr, eexpr:GExpr);
  GEIf(econd:GExpr, eif:GExpr, eelse:Null<GExpr>);
  GEWhile(econd:GExpr, e:GExpr, normalWhile:Bool);
  GESwitch(e:GExpr, cases:Cluster<GCase>, edef:Null<GExpr>);
  GETry(e:GExpr, catches:Cluster<GCatch>);
  GEReturn(?e:GExpr);
  GEBreak;
  GEContinue;
  GEUntyped(e:GExpr);
  GEThrow(e:GExpr);
  GECast(e:GExpr, t:Null<GComplexType>);
  GETernary(econd:GExpr, eif:GExpr, eelse:GExpr);
  GECheckType(e:GExpr, t:GComplexType);
  GEMeta(s:GMetadataEntry, e:GExpr);
  GEIs(e:GExpr, t:GComplexType);
}
class GExprCtr extends Clazz{
  static public function unit(){
    return new GExprCtr(); 
  } 
  private function lift(self:GExprSum){
    return GExpr.lift(self);
  }
  public function Const(c:CTR<GConstantCtr,GConstant>){
    return lift(GEConst(c(GConstant.__)));
  } 
  public function Path(string:String){
    final parts = string.split(".");
    return parts.tail().lfold(
        (next:String,memo:GExpr) -> this.Field(
          _ -> memo,
          next        
        ),
        this.Const(_ -> _.Ident(parts.head().fudge()))
      );
  }
  public function FieldPath(name:String,pack:Cluster<String>){
    final head = pack.head().defv(name);

    return pack.is_defined().if_else(
      () -> pack.tail().snoc(name).lfold(
        (next:String,memo:GExpr) -> this.Field(
          _ -> memo,
          next        
        ),
        this.Const(_ -> _.Ident(head))
      ),
      () -> this.Const(_ -> _.Ident(head))
    );
  }
  public function Array(lhs:CTR<GExprCtr,GExpr>,rhs:CTR<GExprCtr,GExpr>){
    return lift(GEArray(lhs(this),rhs(this)));
  }
  public function Binop(op,l:CTR<GExprCtr,GExpr>,r:CTR<GExprCtr,GExpr>){
    return lift(GEBinop(op,l(this),r(this)));
  }
  #if (haxe_ver > 4.205)
  public function Field(e:CTR<GExprCtr,GExpr>,field:String,?kind){
    return lift(GEField(e(this),field,kind));
  }
  #else
  public function Field(e:CTR<GExprCtr,GExpr>,field:String){
    return lift(GEField(e(this),field));
  }
  #end
  public function Parenthesis(e:CTR<GExprCtr,GExpr>){
    return lift(GEParenthesis(e(this)));
  }
  public function Parens(e:CTR<GExprCtr,GExpr>){
    return lift(GEParenthesis(e(this)));
  }
  public function ObjectDecl(fields:CTR<GObjectFieldCtr,Cluster<GObjectField>>){
    return lift(GEObjectDecl(fields(GObjectField.__)));
  }
  public function ArrayDecl(values:CTR<GExprCtr,Cluster<GExpr>>){
    return lift(GEArrayDecl(values(this)));
  }
  public function Call(e:CTR<GExprCtr,GExpr>,params:CTR<GExprCtr,Cluster<GExpr>>){
    return lift(GECall(e(this),params(this)));
  }
  public function New(t:CTR<GTypePathCtr,GTypePath>,params:CTR<GExprCtr,Cluster<GExpr>>){
    return lift(GENew(t(GTypePath.__),params(this)));
  }
  public function Unop(op,postFix,e:CTR<GExprCtr,GExpr>){
    return lift(GEUnop(op,postFix,e(this)));
  }
  public function Vars(vars:CTR<GVarCtr,Cluster<GVar>>){
    return lift(GEVars(vars(GVar.__)));
  }
  public function Function(f:CTR<GFunctionCtr,GFunction>,?kind){
    return lift(GEFunction(kind,f(GFunction.__)));
  }
  public function Block(exprs:CTR<GExprCtr,Cluster<GExpr>>){
    return lift(GEBlock(exprs(this)));
  }
  public function For(it:CTR<GExprCtr,GExpr>,expr:CTR<GExprCtr,GExpr>){
    return lift(GEFor(it(this),expr(this)));
  }
  public function If(it:CTR<GExprCtr,GExpr>,expr:CTR<GExprCtr,GExpr>,?eelse:CTR<GExprCtr,GExpr>){
    return lift(GEIf(it(this),expr(this),__.option(eelse).map(f -> f(this)).defv(null)));
  }
  public function While(econd:CTR<GExprCtr,GExpr>,expr:CTR<GExprCtr,GExpr>,normalWhile){
    return lift(GEWhile(econd(this),expr(this),normalWhile));
  }
  public function Switch(e:CTR<GExprCtr,GExpr>,cases:CTR<GCaseCtr,Cluster<GCase>>,?edef:CTR<GExprCtr,GExpr>){
    return lift(GESwitch(e(this),cases(GCase.__),__.option(edef).map( f -> f(this)).defv(null)));
  }
  public function Try(e:CTR<GExprCtr,GExpr>,catches:CTR<GCatchCtr,Cluster<GCatch>>){
    return lift(GETry(e(this),catches(GCatch.__)));
  }
  public function Return(?e:CTR<GExprCtr,GExpr>){
    return lift(GEReturn(__.option(e).map(f -> f(this)).defv(null)));
  }
  public function Break(){
    return lift(GEBreak);
  }
  public function Continue(){
    return lift(GEContinue);
  }
  public function Untyped(e:CTR<GExprCtr,GExpr>){
    return lift(GEUntyped(e(this)));
  }
  public function Throw(e:CTR<GExprCtr,GExpr>){
    return lift(GEThrow(e(this)));
  }
  public function Cast(e:CTR<GExprCtr,GExpr>,t:CTR<GComplexTypeCtr,GComplexType>){
    return lift(GECast(e(this),__.option(t).map(f -> f(GComplexType.__)).defv(null)));
  }
  public function Ternary(cond:CTR<GExprCtr,GExpr>,eif:CTR<GExprCtr,GExpr>,eelse:CTR<GExprCtr,GExpr>){
    return lift(GETernary(cond(this),eif(this),eelse(this)));
  }
  public function CheckType(e:CTR<GExprCtr,GExpr>,t:CTR<GComplexTypeCtr,GComplexType>){
    return lift(GECheckType(e(this),t(GComplexType.__)));
  }
  public function Meta(s:CTR<GMetadataEntryCtr,GMetadataEntry>,e:CTR<GExprCtr,GExpr>){
    return lift(GEMeta(s(GMetadataEntry.__),e(this)));
  }
  public function Is(e:CTR<GExprCtr,GExpr>,t:CTR<GComplexTypeCtr,GComplexType>){
    return lift(GEIs(e(this),t(GComplexType.__)));
  }
}
@:using(stx.g.lang.expr.GExpr.GExprLift)
@:forward abstract GExpr(GExprSum) from GExprSum to GExprSum{
  static public var __(default,never) = new GExprCtr();
  public function new(self) this = self;
  @:noUsing static public function lift(self:GExprSum):GExpr return new GExpr(self);

  public function prj():GExprSum return this;
  private var self(get,never):GExpr;
  private function get_self():GExpr return lift(this);

  public function toSource():GSource{
		return Printer.ZERO.printExpr(self);
	}
}
class GExprLift{
  static public function to_macro_at(self:Null<GExpr>,pos:Position):Expr{
    final f = to_macro_at.bind(_,pos);
    return {
      pos     : pos,
      expr    :
        switch(self){
          case GEConst(c)                     : EConst(c.to_macro_at(pos));
          case GEArray(e1, e2)                : EArray(f(e1), f(e2));
          case GEBinop(op, e1, e2)            : EBinop(op.to_macro_at(pos), f(e1), f(e2));
          #if (haxe_ver > 4.205) 
          case GEField(e, field, kind)        : EField(f(e), field, __.option(kind).map(x -> x.to_macro_at(pos)).defv(null));
          #else
          case GEField(e, field)              : EField(f(e), field);
          #end
          case GEParenthesis(e)               : EParenthesis(f(e));
          case GEObjectDecl(fields)           : EObjectDecl(fields.map(e -> e.to_macro_at(pos)).prj());
          case GEArrayDecl(values)            : EArrayDecl(values.map(e -> e.to_macro_at(pos)).prj());
          case GECall(e, params)              : ECall(f(e), params.map(e -> e.to_macro_at(pos)).prj());
          case GENew(t, params)               : ENew(t.to_macro_at(pos), params.map(e -> e.to_macro_at(pos)).prj());
          case GEUnop(op, postFix, e)         : EUnop(op.to_macro_at(pos), postFix, e.to_macro_at(pos));
          case GEVars(vars)                   : EVars(vars.map(e -> GVar._.to_macro_at(e,pos)).prj());
          case GEFunction(kind, f)            : EFunction(__.option(kind).map(x -> x.to_macro_at(pos)).defv(null), f.to_macro_at(pos));
          case GEBlock(exprs)                 : EBlock(exprs.map(e -> e.to_macro_at(pos)).prj());
          case GEFor(i, eexpr)                : EFor(i.to_macro_at(pos), eexpr.to_macro_at(pos));
          case GEIf(econd, eif, eelse)        : EIf(econd.to_macro_at(pos), eif.to_macro_at(pos), __.option(eelse).map(x -> x.to_macro_at(pos)).defv(null));
          case GEWhile(econd, e, normalWhile) : EWhile(econd.to_macro_at(pos), e.to_macro_at(pos), normalWhile);
          case GESwitch(e, cases, edef)       : ESwitch(e.to_macro_at(pos), cases.map(e -> e.to_macro_at(pos)).prj(), __.option(edef).map(x -> x.to_macro_at(pos)).defv(null));
          case GETry(e, catches)              : ETry(e.to_macro_at(pos), catches.map(e -> e.to_macro_at(pos)).prj());
          case GEReturn(e)                    : EReturn(__.option(e).map(x -> x.to_macro_at(pos)).defv(null));
          case GEBreak                        : EBreak;
          case GEContinue                     : EContinue;
          case GEUntyped(e)                   : EUntyped(e.to_macro_at(pos));
          case GEThrow(e)                     : EThrow(e.to_macro_at(pos));
          case GECast(e, t)                   : ECast(e.to_macro_at(pos), __.option(t).map(x -> x.to_macro_at(pos)).defv(null));
          case GETernary(econd, eif, eelse)   : ETernary(econd.to_macro_at(pos), eif.to_macro_at(pos), eelse.to_macro_at(pos));
          case GECheckType(e, t)              : ECheckType(e.to_macro_at(pos), t.to_macro_at(pos));
          case GEMeta(s, e)                   : EMeta(s.to_macro_at(pos), e.to_macro_at(pos));
          case GEIs(e, t)                     : EIs(e.to_macro_at(pos), t.to_macro_at(pos));
          case null                           : null;
      }
    }
  }
  // static public function spell(self:GExpr){
  //   final self = __.g().expr();
  //   return switch(self){
  //     case GEConst(c)                     : 
  //       e.Call(
  //         e.Path('stx.g.lang.expr.GExpr.GExprSum.GEConst'),
  //         [
  //           c.spell()
  //         ]
  //       );
  //     case GEArray(e1, e2)                : 
  //       e.Call(
  //         e.Path('stx.g.lang.expr.GExpr.GExprSum.GEArray'),
  //         [
  //           e1.spell(),
  //           e2.spell()
  //         ]
  //       );
  //     case GEBinop(op, e1, e2)            : EBinop(op.to_macro_at(pos), f(e1), f(e2));
  //     case GEField(e, field, kind)        : EField(f(e), field, __.option(kind).map(x -> x.to_macro_at(pos)).defv(null));
  //     case GEParenthesis(e)               : EParenthesis(f(e));
  //     case GEObjectDecl(fields)           : EObjectDecl(fields.map(e -> e.to_macro_at(pos)).prj());
  //     case GEArrayDecl(values)            : EArrayDecl(values.map(e -> e.to_macro_at(pos)).prj());
  //     case GECall(e, params)              : ECall(f(e), params.map(e -> e.to_macro_at(pos)).prj());
  //     case GENew(t, params)               : ENew(t.to_macro_at(pos), params.map(e -> e.to_macro_at(pos)).prj());
  //     case GEUnop(op, postFix, e)         : EUnop(op.to_macro_at(pos), postFix, e.to_macro_at(pos));
  //     case GEVars(vars)                   : EVars(vars.map(e -> GVar._.to_macro_at(e,pos)).prj());
  //     case GEFunction(kind, f)            : EFunction(__.option(kind).map(x -> x.to_macro_at(pos)).defv(null), f.to_macro_at(pos));
  //     case GEBlock(exprs)                 : EBlock(exprs.map(e -> e.to_macro_at(pos)).prj());
  //     case GEFor(i, eexpr)                : EFor(i.to_macro_at(pos), eexpr.to_macro_at(pos));
  //     case GEIf(econd, eif, eelse)        : EIf(econd.to_macro_at(pos), eif.to_macro_at(pos), __.option(eelse).map(x -> x.to_macro_at(pos)).defv(null));
  //     case GEWhile(econd, e, normalWhile) : EWhile(econd.to_macro_at(pos), e.to_macro_at(pos), normalWhile);
  //     case GESwitch(e, cases, edef)       : ESwitch(e.to_macro_at(pos), cases.map(e -> e.to_macro_at(pos)).prj(), __.option(edef).map(x -> x.to_macro_at(pos)).defv(null));
  //     case GETry(e, catches)              : ETry(e.to_macro_at(pos), catches.map(e -> e.to_macro_at(pos)).prj());
  //     case GEReturn(e)                    : EReturn(__.option(e).map(x -> x.to_macro_at(pos)).defv(null));
  //     case GEBreak                        : EBreak;
  //     case GEContinue                     : EContinue;
  //     case GEUntyped(e)                   : EUntyped(e.to_macro_at(pos));
  //     case GEThrow(e)                     : EThrow(e.to_macro_at(pos));
  //     case GECast(e, t)                   : ECast(e.to_macro_at(pos), __.option(t).map(x -> x.to_macro_at(pos)).defv(null));
  //     case GETernary(econd, eif, eelse)   : ETernary(econd.to_macro_at(pos), eif.to_macro_at(pos), eelse.to_macro_at(pos));
  //     case GECheckType(e, t)              : ECheckType(e.to_macro_at(pos), t.to_macro_at(pos));
  //     case GEMeta(s, e)                   : EMeta(s.to_macro_at(pos), e.to_macro_at(pos));
  //     case GEIs(e, t)                     : EIs(e.to_macro_at(pos), t.to_macro_at(pos));
  //   }
  // }
}