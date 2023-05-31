package eu.ohmrun.glot.expr;

final Expr = __.glot().Expr;

class GCatchCtr extends Clazz{
  public function Make(name:String,expr:CTR<GExprCtr,GExpr>,type:CTR<GComplexTypeCtr,GComplexType>){
    return GCatch.make(
      name,
      expr(Expr.GExpr),
      __.option(type).map(f -> f(Expr.GComplexType)).defv(null)
    );
  }
}
typedef GCatchDef = {
	var name:String;
  var expr:GExpr;
	var ?type:GComplexType;
}
@:using(eu.ohmrun.glot.expr.GCatch.GCatchLift)
@:forward abstract GCatch(GCatchDef) from GCatchDef to GCatchDef{
  static public var _(default,never) = GCatchLift;
  public function new(self) this = self;
  @:noUsing static public function lift(self:GCatchDef):GCatch return new GCatch(self);
  @:noUsing static public function make(name:String,expr:GExpr,?type:GComplexType){
    return lift({
      name  : name,
      expr  : expr,
      type  : type
    });
  }
  public function prj():GCatchDef return this;
  private var self(get,never):GCatch;
  private function get_self():GCatch return lift(this);

  public function toSource():GSource{
		return Printer.ZERO.printCatch(this);
	}
}
class GCatchLift{
  #if macro
  static public function to_macro_at(self:GCatch,pos:Position):Catch{
    return {
      name  : self.name,
      expr  : self.expr.to_macro_at(pos),
      type  : __.option(self.type).map(x -> x.to_macro_at(pos)).defv(null)
    };
  }
  #end
}