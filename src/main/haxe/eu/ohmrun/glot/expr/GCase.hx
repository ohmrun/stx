package eu.ohmrun.glot.expr;

final Expr = __.glot().Expr;

class GCaseCtr extends Clazz{
  public function Make(values:CTR<GExprCtr,Cluster<GExpr>>,?guard:CTR<GExprCtr,GExpr>,?expr:CTR<GExprCtr,GExpr>){
    final ctr = Expr.GExpr;
    return GCase.make(
      values(ctr),
      __.option(guard).map(f -> f(ctr)).defv(null),
      __.option(expr).map(f -> f(ctr)).defv(null)
    );
  }
}
typedef GCaseDef = {
	final values:Cluster<GExpr>;
	final ?guard:GExpr;
	final ?expr:GExpr;
}
@:using(eu.ohmrun.glot.expr.GCase.GCaseLift)
@:forward abstract GCase(GCaseDef) from GCaseDef to GCaseDef{
  public function new(self) this = self;
  @:noUsing static public function lift(self:GCaseDef):GCase return new GCase(self);
  @:noUsing static public function make(values:Cluster<GExpr>,?guard:GExpr,?expr:GExpr){
    return lift({
      values  : values,
      guard   : guard,
      expr    : expr 
    });
  }
  public function prj():GCaseDef return this;
  private var self(get,never):GCase;
  private function get_self():GCase return lift(this);

  // public function toSource():GSource{
	// 	return Printer.ZERO.printCase(this);
	// }
}
class GCaseLift{
  #if macro
  static public function to_macro_at(self:GCase,pos:Position):Case{
    return @:privateAccess {
      values  : __.option(self.values).map(x -> x.map(y -> y.to_macro_at(pos)).prj()).defv([]),
      guard   : __.option(self.guard).map(x -> x.to_macro_at(pos)).defv(null),
      expr    : __.option(self.expr).map(x -> x.to_macro_at(pos)).defv(null) 
    }
  }
  #end
}