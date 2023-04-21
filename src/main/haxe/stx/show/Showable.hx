package stx.show;

typedef ShowableDef<T> = {
  public function show(value:T,state:State):Res<Response,ShowFailure>;
  public function toShowable():Showable<T>;
}
interface ShowableApi<T>{
  public function show(value:T,state:State):Res<Response,ShowFailure>;
  public function toShowable():Showable<T>;
}
abstract class ShowableCls<T> implements ShowableApi<T>{
  public function new(){}
  abstract public function show(value:T,state:State):Res<Response,ShowFailure>;
  public function toShowable():Showable<T>{
    return this;
  }
}
@:forward abstract Showable<T>(ShowableApi<T>) from ShowableApi<T> to ShowableApi<T>{
  public function new(self) this = self;
  @:noUsing static public function lift<T>(self:ShowableApi<T>):Showable<T> return new Showable(self);

  public function prj():ShowableApi<T> return this;
  private var self(get,never):Showable<T>;
  private function get_self():Showable<T> return lift(this);
}