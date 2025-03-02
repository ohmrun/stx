package stx.makro.type;

class HRefCtr extends Clazz{
  public function Make<T>(get:()->T,toString:()->String){
    return HRef.make(get,toString);
  }
  public function Lift<T>(self:haxe.macro.Type.Ref<T>){
    return HRef.lift(self);
  }
}
typedef HRefDef<T> = haxe.macro.Type.Ref<T>;

@:using(stx.makro.type.HRef.HRefLift)
@:forward abstract HRef<T>(HRefDef<T>) from HRefDef<T> to HRefDef<T>{
  
  public inline function new(self:HRefDef<T>) this = self;
  @:noUsing static inline public function lift<T>(self:HRefDef<T>):HRef<T> return new HRef(self);
  @:noUsing static inline public function make<T>(get:Void->T,toString:Void->String){
    return lift({
      get       : get,
      toString  : toString
    });
  }
  public function prj():haxe.macro.Type.Ref<T> return this;
  private var self(get,never):HRef<T>;
  private function get_self():HRef<T> return lift(this);
}
class HRefLift{
  static public inline function lift<T>(self:HRefDef<T>):HRef<T>{
    return HRef.lift(self);
  }
}