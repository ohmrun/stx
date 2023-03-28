package stx.assert.comparable.term;

import stx.nano.Junction in TJunction;

class Junction<T> extends ComparableCls<TJunction<T>>{
  final inner : Comparable<T>;
  public function new(inner){
    this.inner = inner;
  }
  public function lt(){
    return new stx.assert.ord.term.Junction(inner.lt());
  }
  public function eq(){
    return new stx.assert.eq.term.Junction(inner.eq());
  }
}