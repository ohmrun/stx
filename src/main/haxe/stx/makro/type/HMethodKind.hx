package stx.makro.type;

typedef HMethodKindDef = haxe.macro.Type.MethodKind;

@:using(stx.makro.type.HMethodKind.HMethodKindLift)
abstract HMethodKind(HMethodKindDef) from HMethodKindDef to HMethodKindDef{
  static public var _(default,never) = HMethodKindLift;
  public inline function new(self:HMethodKindDef) this = self;
  @:noUsing static inline public function lift(self:HMethodKindDef):HMethodKind return new HMethodKind(self);

  public function prj():HMethodKindDef return this;
  private var self(get,never):HMethodKind;
  private function get_self():HMethodKind return lift(this);
}
class HMethodKindLift{
  static public inline function lift(self:HMethodKindDef):HMethodKind{
    return HMethodKind.lift(self);
  }
}