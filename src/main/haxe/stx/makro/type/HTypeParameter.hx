package stx.makro.type;

final __type = __.makro().type;

class HTypeParameterCtr extends Clazz{
  public function Make(name:String,type:CTR<HTypeCtr,HType>,?defaultType:Null<CTR<HTypeCtr,HType>>){
    return HTypeParameter.make(
      name,
      type.apply(__type.HType),
      __.option(defaultType).map(x -> x.apply(__type.HType)).defv(null)
    );
  }
}
@:using(stx.makro.type.HTypeParameter.HTypeParameterLift)
@:forward abstract HTypeParameter(haxe.macro.Type.TypeParameter) from haxe.macro.Type.TypeParameter to haxe.macro.Type.TypeParameter {
  static public var _(default,never) = HTypeParameterLift;
  public inline function new(self:haxe.macro.Type.TypeParameter) this = self;
  @:noUsing static inline public function lift(self:haxe.macro.Type.TypeParameter):HTypeParameter return new HTypeParameter(self);
  @:noUsing static inline public function make(name:String,t:Type,?defaultType){
    return lift({
      name          : name,
      t             : t,
      defaultType   : defaultType
    });    
  }
  public function prj():haxe.macro.Type.TypeParameter return this;
  private var self(get,never):HTypeParameter;
  private function get_self():HTypeParameter return lift(this);
}
class HTypeParameterLift{
  static public inline function lift(self:haxe.macro.Type.TypeParameter):HTypeParameter{
    return HTypeParameter.lift(self);
  }
}

/*
  typedef TypeParameter = {
    var name:String;
    var t:Type;
    var ?defaultType:Null<Type>;
  }
*/