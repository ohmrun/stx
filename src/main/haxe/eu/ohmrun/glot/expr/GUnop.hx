package eu.ohmrun.glot.expr;

class GUnopCtr extends Clazz{
  public function Increment() return GUnop.lift(GOpIncrement);
  public function Decrement() return GUnop.lift(GOpDecrement);
  public function Not()       return GUnop.lift(GOpNot);
  public function Neg()       return GUnop.lift(GOpNeg);
  public function NegBits()   return GUnop.lift(GOpNegBits);
  public function Spread()    return GUnop.lift(GOpSpread);
}
enum GUnopSum{
  GOpIncrement;//`++`
  GOpDecrement;//`--`
  GOpNot;//`!`
  GOpNeg;//`-`
  GOpNegBits;//`~`
  GOpSpread;//`...`
}
@:using(eu.ohmrun.glot.expr.GUnop.GUnopLift)
abstract GUnop(GUnopSum) from GUnopSum to GUnopSum{
  public function new(self) this = self;
  @:noUsing static public function lift(self:GUnopSum):GUnop return new GUnop(self);

  public function prj():GUnopSum return this;
  private var self(get,never):GUnop;
  private function get_self():GUnop return lift(this);

  public function toSource():GSource{
		return Printer.ZERO.printUnop(this);
	}
}
class GUnopLift{
  #if macro
  static public function to_macro_at(self:GUnop,pos:Position):Unop{
    return switch(self){
      case GOpIncrement     : OpIncrement;
      case GOpDecrement     : OpDecrement;
      case GOpNot           : OpNot;
      case GOpNeg           : OpNeg;
      case GOpNegBits       : OpNegBits;
      case GOpSpread        : OpSpread;
    }
  }
  #end
}
