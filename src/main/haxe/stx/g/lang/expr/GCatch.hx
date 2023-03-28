package stx.g.lang.expr;

class GCatchCtr extends Clazz{
  static public function unit(){
    return new GCatchCtr();
  }
  private function lift(self:GCatchDef):GCatch{
    return GCatch.lift(self);
  }
  public function Make(name:String,expr:CTR<GExprCtr,GExpr>,type:CTR<GComplexTypeCtr,GComplexType>){
    return GCatch.make(
      name,
      expr(GExpr.__),
      __.option(type).map(f -> f(GComplexType.__)).defv(null)
    );
  }
}
typedef GCatchDef = {
	var name:String;
  var expr:GExpr;
	var ?type:GComplexType;
}
@:using(stx.g.lang.expr.GCatch.GCatchLift)
@:forward abstract GCatch(GCatchDef) from GCatchDef to GCatchDef{
  static public var _(default,never) = GCatchLift;
  static public var __(default,never) = new GCatchCtr();
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
  static public function to_macro_at(self:GCatch,pos:Position){
    return {
      name  : self.name,
      expr  : self.expr.to_macro_at(pos),
      type  : __.option(self.type).map(x -> x.to_macro_at(pos)).defv(null)
    };
  }
}