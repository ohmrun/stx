package stx.makro.type;

@:using(stx.makro.type.HDefType.HDefTypeLift)
@:forward abstract HDefType(DefType) from DefType to DefType{
  static public var _(default,never) = HDefTypeLift;
  public inline function new(self:DefType) this = self;
  @:noUsing static inline public function lift(self:DefType):HDefType return new HDefType(self);

  public function prj():DefType return this;
  private var self(get,never):HDefType;
  private function get_self():HDefType return lift(this);
}
class HDefTypeLift{
  static public inline function lift(self:DefType):HDefType{
    return HDefType.lift(self);
  }
  static public function toBaseType(self:DefType):HBaseType{
    return HBaseType.lift(self);
  }
}