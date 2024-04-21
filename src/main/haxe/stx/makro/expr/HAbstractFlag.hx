package stx.makro.expr;

typedef HAbstractFlagDef = haxe.macro.Expr.AbstractFlag;

@:using(stx.makro.expr.HAbstractFlag.HAbstractFlagLift)
abstract HAbstractFlag(HAbstractFlagDef) from HAbstractFlagDef to HAbstractFlagDef{
  static public var _(default,never) = HAbstractFlagLift;
  public inline function new(self:HAbstractFlagDef) this = self;
  @:noUsing static inline public function lift(self:HAbstractFlagDef):HAbstractFlag return new HAbstractFlag(self);

  public function prj():HAbstractFlagDef return this;
  private var self(get,never):HAbstractFlag;
  private function get_self():HAbstractFlag return lift(this);
}
class HAbstractFlagLift{
  static public inline function lift(self:HAbstractFlagDef):HAbstractFlag{
    return HAbstractFlag.lift(self);
  }
}