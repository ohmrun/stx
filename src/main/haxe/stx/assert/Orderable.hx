package stx.assert;

import stx.assert.orderable.term.Anon;

interface OrderableApi<T>{
  public function lt():Ord<T>;
}

@:forward abstract Orderable<T>(OrderableApi<T>) from OrderableApi<T> to OrderableApi<T>{
  public function new(self){
    this = self;
  }
  static public function Anon<T>(self:T -> T -> Ordered):Orderable<T>{
    return new Anon(Ord.Anon(self));
  }
}