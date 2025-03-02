package eu.ohmrun.glot.expr;

final Expr = __.glot().Expr;

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
  public inline function Const(c:CTR<GConstantCtr,GConstant>){
    return Constant(c);
  }
  public function Constant(c:CTR<GConstantCtr,GConstant>){
    return GExpr.lift(GEConst(c.apply(Expr.GConstant)));
  } 
  public function Path(string:String):GExpr{
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
  public function GArray(lhs:CTR<GExprCtr,GExpr>,rhs:CTR<GExprCtr,GExpr>){
    return GExpr.lift(GEArray(lhs.apply(this),rhs.apply(this)));
  }
  public function Binop(op,l:CTR<GExprCtr,GExpr>,r:CTR<GExprCtr,GExpr>){
    return GExpr.lift(GEBinop(op,l.apply(this),r.apply(this)));
  }
  #if (haxe_ver > 4.205)
  public function Field(e:CTR<GExprCtr,GExpr>,field:String,?kind){
    return GExpr.lift(GEField(e.apply(this),field,kind));
  }
  #else
  public function Field(e:CTR<GExprCtr,GExpr>,field:String){
    return GExpr.lift(GEField(e.apply(this),field));
  }
  #end
  public function Parenthesis(e:CTR<GExprCtr,GExpr>){
    return GExpr.lift(GEParenthesis(e.apply(this)));
  }
  public function Parens(e:CTR<GExprCtr,GExpr>){
    return GExpr.lift(GEParenthesis(e.apply(this)));
  }
  public function ObjectDecl(fields:CTR<GObjectFieldCtr,Cluster<GObjectField>>){
    return GExpr.lift(GEObjectDecl(fields.apply(Expr.GObjectField)));
  }
  public function ArrayDecl(values:CTR<GExprCtr,Cluster<GExpr>>){
    return GExpr.lift(GEArrayDecl(values.apply(this)));
  }
  public function Call(e:CTR<GExprCtr,GExpr>,params:CTR<GExprCtr,Cluster<GExpr>>){
    return GExpr.lift(GECall(e.apply(this),params.apply(this)));
  }
  public function Nu(t:CTR<GTypePathCtr,GTypePath>,params:CTR<GExprCtr,Cluster<GExpr>>){
    return GExpr.lift(GENew(t.apply(Expr.GTypePath),params.apply(this)));
  }
  public function Unop(op,postFix,e:CTR<GExprCtr,GExpr>){
    return GExpr.lift(GEUnop(op,postFix,e.apply(this)));
  }
  public function Vars(vars:CTR<GVarCtr,Cluster<GVar>>){
    return GExpr.lift(GEVars(vars.apply(Expr.GVar)));
  }
  public function Function(f:CTR<GFunctionCtr,GFunction>,?kind){
    return GExpr.lift(GEFunction(kind,f.apply(Expr.GFunction)));
  }
  public function Block(exprs:CTR<GExprCtr,Cluster<GExpr>>){
    return GExpr.lift(GEBlock(exprs.apply(this)));
  }
  public function For(it:CTR<GExprCtr,GExpr>,expr:CTR<GExprCtr,GExpr>){
    return GExpr.lift(GEFor(it.apply(this),expr.apply(this)));
  }
  public function If(it:CTR<GExprCtr,GExpr>,expr:CTR<GExprCtr,GExpr>,?eelse:CTR<GExprCtr,GExpr>){
    return GExpr.lift(GEIf(it.apply(this),expr.apply(this),__.option(eelse).map(f -> f.apply(this)).defv(null)));
  }
  public function While(econd:CTR<GExprCtr,GExpr>,expr:CTR<GExprCtr,GExpr>,normalWhile){
    return GExpr.lift(GEWhile(econd.apply(this),expr.apply(this),normalWhile));
  }
  public function Switch(e:CTR<GExprCtr,GExpr>,cases:CTR<GCaseCtr,Cluster<GCase>>,?edef:CTR<GExprCtr,GExpr>){
    return GExpr.lift(GESwitch(e.apply(this),cases.apply(Expr.GCase),__.option(edef).map( f -> f.apply(this)).defv(null)));
  }
  public function Try(e:CTR<GExprCtr,GExpr>,catches:CTR<GCatchCtr,Cluster<GCatch>>){
    return GExpr.lift(GETry(e.apply(this),catches.apply(Expr.GCatch)));
  }
  public function Return(?e:CTR<GExprCtr,GExpr>){
    return GExpr.lift(GEReturn(__.option(e).map(f -> f.apply(this)).defv(null)));
  }
  public function Break(){
    return GExpr.lift(GEBreak);
  }
  public function Continue(){
    return GExpr.lift(GEContinue);
  }
  public function Untyped(e:CTR<GExprCtr,GExpr>){
    return GExpr.lift(GEUntyped(e.apply(this)));
  }
  public function Throw(e:CTR<GExprCtr,GExpr>){
    return GExpr.lift(GEThrow(e.apply(this)));
  }
  public function Cast(e:CTR<GExprCtr,GExpr>,t:CTR<GComplexTypeCtr,GComplexType>){
    return GExpr.lift(GECast(e.apply(this),__.option(t).map(f -> f.apply(Expr.GComplexType)).defv(null)));
  }
  public function Ternary(cond:CTR<GExprCtr,GExpr>,eif:CTR<GExprCtr,GExpr>,eelse:CTR<GExprCtr,GExpr>){
    return GExpr.lift(GETernary(cond.apply(this),eif.apply(this),eelse.apply(this)));
  }
  public function CheckType(e:CTR<GExprCtr,GExpr>,t:CTR<GComplexTypeCtr,GComplexType>){
    return GExpr.lift(GECheckType(e.apply(this),t.apply(Expr.GComplexType)));
  }
  public function Meta(s:CTR<GMetadataEntryCtr,GMetadataEntry>,e:CTR<GExprCtr,GExpr>){
    return GExpr.lift(GEMeta(s.apply(Expr.GMetadataEntry),e.apply(this)));
  }
  public function Is(e:CTR<GExprCtr,GExpr>,t:CTR<GComplexTypeCtr,GComplexType>){
    return GExpr.lift(GEIs(e.apply(this),t.apply(Expr.GComplexType)));
  }
}
@:using(eu.ohmrun.glot.expr.GExpr.GExprLift)
@:forward abstract GExpr(GExprSum) from GExprSum to GExprSum{
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
  #if macro
  static public function to_macro_at(self:Null<GExpr>,pos:Position):Expr{
    final f = to_macro_at.bind(_,pos);
    return {
      pos     : pos,
      expr    :
        @:privateAccess switch(self){
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
  #end
  // static public function spell(self:GExpr){
  //   final self = __.glot().expr();
  //   return switch(self){
  //     case GEConst(c)                     : 
  //       e.Call(
  //         e.Path('eu.ohmrun.glot.expr.Expr.GExprSum.GEConst'),
  //         [
  //           c.spell()
  //         ]
  //       );
  //     case GEArray(e1, e2)                : 
  //       e.Call(
  //         e.Path('eu.ohmrun.glot.expr.Expr.GExprSum.GEArray'),
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