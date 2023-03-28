package stx.makro.expr;
//@:using(stx.makro.expr.HExprDef.HExprDefLift)
abstract HExprDef(StdExprDef){
  static public var _(default,never) = HExprDefLift;
  static public var MARK(default,null) = mark();
  static public var ZERO(default,null) = unit();
  
  @:noUsing static public function lift(self:StdExprDef):HExprDef{
    return new HExprDef(self);
  }
  static public function unit():HExprDef{
    return lift(StdExprDef.EConst(CIdent('null')));
  }
  static public function mark():HExprDef{
    return lift(StdExprDef.EConst(CIdent('$')));
  }
  @:noUsing static public function EConst(v):HExprDef{
    return lift(StdExprDef.EConst(v));
  }
  @:noUsing static public function ESwitch(e:HExpr,cases:Cluster<Case>,def:HExpr):HExprDef{
    return lift(StdExprDef.ESwitch(e.toExpr(),cases.prj(),def.toExpr()));
  }
  @:noUsing static public function EArrayDecl(vals:HExprCluster):HExprDef{
    return lift(StdExprDef.EArrayDecl(vals.toExprArray()));
  }
  @:noUsing static public function ECall(self:HExpr,with:HExprCluster):HExprDef{
    return lift(StdExprDef.ECall(self.toExpr(),with.toExprArray()));
  }
  @:noUsing static public function EField(e:HExpr,f:String):HExprDef{
    return lift(StdExprDef.EField(e.toExpr(),f));
  }
  @:noUsing static public function EBlock(arr:HExprCluster):HExprDef{
    return lift(StdExprDef.EBlock(arr.toExprArray()));
  }
  @:noUsing static public function EFunction(f:HFunction,?kind:FunctionKind){
    return lift(StdExprDef.EFunction(kind, f.prj()));
  }
  @:noUsing static public function EReturn(?e:HExpr){
    return lift(StdExprDef.EReturn(__.option(e).map(e -> e.prj()).defv(null)));
  }
  // @:noUsing static public function ENew(t:HTypePath,?params:Cluster<Expr>){
  //   return lift(StdExprDef.ENew(t.prj(),__.option(params).map(x -> x.prj()).def([]));)
  // }

  public function new(self) this = self;
  public function toHExpr(pos:Position):HExpr{
    return HExpr.make(lift(this),pos);
  }
  public function to_macro_at(pos){
    return toHExpr(pos);
  }
  public function prj(){
    return this;
  }
}
class HExprDefLift{

}