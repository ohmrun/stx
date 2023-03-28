package stx.g.lang.expr;

class GCaseCtr extends Clazz{
  static public function unit(){
    return new GCaseCtr();
  }
  private function lift(self:GCaseDef):GCase{
    return GCase.lift(self);
  }
  public function Make(values:CTR<GExprCtr,Cluster<GExpr>>,?guard:CTR<GExprCtr,GExpr>,?expr:CTR<GExprCtr,GExpr>){
    final ctr = GExprCtr.unit();
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
@:using(stx.g.lang.expr.GCase.GCaseLift)
@:forward abstract GCase(GCaseDef) from GCaseDef to GCaseDef{
  static public var __(default,never) = new GCaseCtr();
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
  static public function to_macro_at(self:GCase,pos:Position){
    return {
      values  : __.option(self.values).map(x -> x.map(y -> y.to_macro_at(pos)).prj()).defv([]),
      guard   : __.option(self.guard).map(x -> x.to_macro_at(pos)).defv(null),
      expr    : __.option(self.expr).map(x -> x.to_macro_at(pos)).defv(null) 
    }
  }
}