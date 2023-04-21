package stx.makro.type;

@:using(stx.makro.type.HClassKind.HClassKindLift)
abstract HClassKind(StdClassKind) from StdClassKind to StdClassKind{
  static public var _(default,never) = HClassKindLift;
  public inline function new(self:StdClassKind) this = self;
  static inline public function lift(self:StdClassKind):HClassKind return new HClassKind(self);

  public function prj():StdClassKind return this;
  private var self(get,never):HClassKind;
  private function get_self():HClassKind return lift(this);
}
class HClassKindLift{
  static public inline function lift(self:StdClassKind):HClassKind{
    return HClassKind.lift(self);
  }
}