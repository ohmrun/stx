package stx.makro.type;

typedef TypeAppliedValueDef<T> = { data : T, params : Cluster<HType> };

@:using(stx.makro.type.TypeAppliedValue.TypeAppliedValueLift)
@:forward abstract TypeAppliedValue<T>(TypeAppliedValueDef<T>) from TypeAppliedValueDef<T> to TypeAppliedValueDef<T>{
  static public var _(default,never) = TypeAppliedValueLift;
  public inline function new(self:TypeAppliedValueDef<T>) this = self;
  @:noUsing static public inline function lift<T>(self:TypeAppliedValueDef<T>):TypeAppliedValue<T> return new TypeAppliedValue(self);
  
  @:noUsing static public inline function make<T>(data:T,params:Cluster<HType>){
    return lift({data : data, params : params});
  }
  public function prj():TypeAppliedValueDef<T> return this;
  private var self(get,never):TypeAppliedValue<T>;
  private function get_self():TypeAppliedValue<T> return lift(this);
}
class TypeAppliedValueLift{
  static public inline function lift<T>(self:TypeAppliedValueDef<T>):TypeAppliedValue<T>{
    return TypeAppliedValue.lift(self);
  }
}