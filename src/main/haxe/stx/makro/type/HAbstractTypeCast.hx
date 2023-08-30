package stx.makro.type;

final type = __.makro().type;

class HAbstractTypeCastCtr extends Clazz{
  static public function Make(t:CTR<HTypeCtr,HType>,field:Null<CTR<HClassFieldCtr,HClassField>>){
    final field = __.option(field).map(x -> x.apply(type.HClassField)).defv(null);
    return HAbstractTypeCast.make(t.apply(type.HType),field);
  }
}
typedef HAbstractTypeCastDef = {t:Type, field:Null<ClassField>};

@:using(stx.makro.type.HAbstractTypeCast.HAbstractTypeCastLift)
@:forward abstract HAbstractTypeCast(HAbstractTypeCastDef) from HAbstractTypeCastDef to HAbstractTypeCastDef{
  static public var _(default,never) = HAbstractTypeCastLift;
  public inline function new(self:HAbstractTypeCastDef) this = self;
  @:noUsing static inline public function lift(self:HAbstractTypeCastDef):HAbstractTypeCast return new HAbstractTypeCast(self);
  @:noUsing static inline public function make(t,field){
    return lift({
      t     : t,
      field : field
    });
  }
  public function prj():HAbstractTypeCastDef return this;
  private var self(get,never):HAbstractTypeCast;
  private function get_self():HAbstractTypeCast return lift(this);
}
class HAbstractTypeCastLift{
  static public inline function lift(self:HAbstractTypeCastDef):HAbstractTypeCast{
    return HAbstractTypeCast.lift(self);
  }
}