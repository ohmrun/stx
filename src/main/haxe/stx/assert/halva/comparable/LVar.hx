package stx.assert.halva.comparable;

import eu.ohmrun.halva.LVar in TLVar;

//TODO this is Chunk<T,E>
class LVar<T> extends ComparableCls<TLVar<T>>{
  public final inner : Comparable<T>;
  public function new(inner){
    this.inner = inner;
  }
  public function lt():Ord<TLVar<T>>{
    return Ord.lift(new stx.assert.halva.ord.LVar(this.inner.lt()));
  }
  public function eq():Eq<TLVar<T>>{
    return Eq.lift(new stx.assert.halva.eq.LVar(this.inner.eq()));
  }
}