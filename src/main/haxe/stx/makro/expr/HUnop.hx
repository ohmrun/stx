package stx.makro.expr;

class HUnopCtr extends Clazz{
  public function Increment() return HUnop.lift(OpIncrement);
  public function Decrement() return HUnop.lift(OpDecrement);
  public function Not()       return HUnop.lift(OpNot);
  public function Neg()       return HUnop.lift(OpNeg);
  public function NegBits()   return HUnop.lift(OpNegBits);
  public function Spread()    return HUnop.lift(OpSpread);
}
typedef HUnopDef = haxe.macro.Expr.Unop;
@:using(stx.makro.expr.HUnop.HUnopLift)
abstract HUnop(HUnopDef) from HUnopDef to HUnopDef{
  public function new(self) this = self;
  @:noUsing static public function lift(self:HUnopDef):HUnop return new HUnop(self);

  public function prj():HUnopDef return this;
  private var self(get,never):HUnop;
  private function get_self():HUnop return lift(this);

}
class HUnopLift{

}
