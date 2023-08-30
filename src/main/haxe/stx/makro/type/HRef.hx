package stx.makro.type;

class HRefCtr extends Clazz{
  public function Make(get,toString){
    return HRef.make(get,toString);
  }
  public function Lift<T>(self:Ref<T>){
    return HRef.lift(self);
  }
}
typedef HRefDef<T> = haxe.macro.Type.Ref<T>;

@:using(stx.makro.type.HRef.HRefLift)
@:forward abstract HRef<T>(HRefDef<T>) from HRefDef<T> to HRefDef<T>{
  static public var _(default,never) = HRefLift;
  public inline function new(self:HRefDef<T>) this = self;
  @:noUsing static inline public function lift<T>(self:HRefDef<T>):HRef<T> return new HRef(self);
  @:noUsing static inline public function make<T>(get:Void->T,toString:Void->String){
    return lift({
      get       : get,
      toString  : toString
    });
  }
  public function prj():HRefDef<T> return this;
  private var self(get,never):HRef<T>;
  private function get_self():HRef<T> return lift(this);
}
class HRefLift{
  static public inline function lift<T>(self:HRefDef<T>):HRef<T>{
    return HRef.lift(self);
  }
}