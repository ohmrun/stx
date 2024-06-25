package stx.assert.pml.comparable;

import eu.ohmrun.Pml.PExpr in TPExpr;

class PExpr<T> extends ComparableCls<TPExpr<T>>{
  var inner : Comparable<T>;
  public function new(inner){
    this.inner = inner;
  }
  public function eq():Eq<TPExpr<T>>{
    return new stx.assert.pml.eq.PExpr(this.inner.eq()).toEqApi();
  }
  public function lt():Ord<TPExpr<T>>{
    return new stx.assert.pml.ord.PExpr(this.inner.lt()).toOrdApi();
  }
}