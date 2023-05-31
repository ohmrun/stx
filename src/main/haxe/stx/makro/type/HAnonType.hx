package stx.makro.type;

@:using(stx.makro.type.HAnonType.HAnonTypeLift)
@:forward abstract HAnonType(AnonType) from AnonType to AnonType{
  static public var _(default,never) = HAnonTypeLift;
  public inline function new(self:AnonType) this = self;
  @:noUsing static inline public function lift(self:AnonType):HAnonType return new HAnonType(self);

  public function prj():AnonType return this;
  private var self(get,never):HAnonType;
  private function get_self():HAnonType return lift(this);
}
class HAnonTypeLift{
  static public inline function lift(self:AnonType):HAnonType{
    return HAnonType.lift(self);
  }
} 