package stx.makro.core;

typedef RefDef<T> = {
  function get():T;
  function toString():String;
}
@:forward abstract Ref<T>(RefDef<T>) from RefDef<T> to RefDef<T>{
  public function new(self) this = self;
  @:noUsing static public function lift<T>(self:RefDef<T>):Ref<T> return new Ref(self);
  

  

  public function prj():RefDef<T> return this;
  private var self(get,never):Ref<T>;
  private function get_self():Ref<T> return lift(this);
}