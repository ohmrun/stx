package stx.assert;

interface EqualableApi<T>{
  public function eq() : Eq<T>;
}
@:forward abstract Equalable<T>(EqualableApi<T>) from EqualableApi<T>{
  public function new(self){
    this = self;
  }
}