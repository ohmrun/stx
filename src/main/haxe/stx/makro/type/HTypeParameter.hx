package stx.makro.type;

@:using(stx.makro.type.HTypeParameter.HTypeParameterLift)
@:forward abstract HTypeParameter(haxe.macro.Type.TypeParameter) from haxe.macro.Type.TypeParameter to haxe.macro.Type.TypeParameter {
  static public var _(default,never) = HTypeParameterLift;
  public inline function new(self:haxe.macro.Type.TypeParameter) this = self;
  @:noUsing static inline public function lift(self:haxe.macro.Type.TypeParameter):HTypeParameter return new HTypeParameter(self);

  public function prj():haxe.macro.Type.TypeParameter return this;
  private var self(get,never):HTypeParameter;
  private function get_self():HTypeParameter return lift(this);
}
class HTypeParameterLift{
  static public inline function lift(self:haxe.macro.Type.TypeParameter):HTypeParameter{
    return HTypeParameter.lift(self);
  }
}