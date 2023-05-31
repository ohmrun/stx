package stx.makro.type;

@:using(stx.makro.type.HEnumField.HEnumFieldLift)
@:forward abstract HEnumField(haxe.macro.Type.EnumField) from haxe.macro.Type.EnumField to haxe.macro.Type.EnumField{
  static public var _(default,never) = HEnumFieldLift;
  public inline function new(self:haxe.macro.Type.EnumField) this = self;
  @:noUsing static inline public function lift(self:haxe.macro.Type.EnumField):HEnumField return new HEnumField(self);

  public function prj():haxe.macro.Type.EnumField return this;
  private var self(get,never):HEnumField;
  private function get_self():HEnumField return lift(this);
}
class HEnumFieldLift{
  static public inline function lift(self:haxe.macro.Type.EnumField):HEnumField{
    return HEnumField.lift(self);
  }
}