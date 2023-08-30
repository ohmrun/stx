package stx.makro.type;

class HMetaAccessCtr extends Clazz{
  public function Lift(self:HMetaAccessDef){
    return HMetaAccess.lift(self);
  }
}
typedef HMetaAccessDef = haxe.macro.Type.MetaAccess;

@:using(stx.makro.type.HMetaAccess.HMetaAccessLift)
abstract HMetaAccess(HMetaAccessDef) from HMetaAccessDef to HMetaAccessDef{
  static public var _(default,never) = HMetaAccessLift;
  public inline function new(self:HMetaAccessDef) this = self;
  @:noUsing static inline public function lift(self:HMetaAccessDef):HMetaAccess return new HMetaAccess(self);

  public function prj():HMetaAccessDef return this;
  private var self(get,never):HMetaAccess;
  private function get_self():HMetaAccess return lift(this);
}
class HMetaAccessLift{
  static public inline function lift(self:HMetaAccessDef):HMetaAccess{
    return HMetaAccess.lift(self);
  }
}