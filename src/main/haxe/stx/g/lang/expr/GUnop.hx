package stx.g.lang.expr;

enum GUnopSum{
  GOpIncrement;//`++`
  GOpDecrement;//`--`
  GOpNot;//`!`
  GOpNeg;//`-`
  GOpNegBits;//`~`
  GOpSpread;//`...`
}
@:using(stx.g.lang.expr.GUnop.GUnopLift)
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
}
