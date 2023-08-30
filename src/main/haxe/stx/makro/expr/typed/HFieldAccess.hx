package stx.makro.expr.typed;

/*
  enum FieldAccess{
    FInstance(c:Ref<ClassType>, params:Array<Type>, cf:Ref<ClassField>);
    FStatic(c:Ref<ClassType>, cf:Ref<ClassField>);
    FAnon(cf:Ref<ClassField>);
    FDynamic(s:String);
    FClosure(c:Null<{c:Ref<ClassType>, params:Array<Type>}>, cf:Ref<ClassField>);
    FEnum(e:Ref<EnumType>, ef:EnumField);
  }
*/

typedef HFieldAccessDef = haxe.macro.Type.FieldAccess;

@:using(stx.makro.expr.typed.HFieldAccess.HFieldAccessLift)
abstract HFieldAccess(HFieldAccessDef) from HFieldAccessDef to HFieldAccessDef{
  static public var _(default,never) = HFieldAccessLift;
  public inline function new(self:HFieldAccessDef) this = self;
  @:noUsing static inline public function lift(self:HFieldAccessDef):HFieldAccess return new HFieldAccess(self);

  public function prj():HFieldAccessDef return this;
  private var self(get,never):HFieldAccess;
  private function get_self():HFieldAccess return lift(this);
}
class HFieldAccessLift{
  static public inline function lift(self:HFieldAccessDef):HFieldAccess{
    return HFieldAccess.lift(self);
  }
}