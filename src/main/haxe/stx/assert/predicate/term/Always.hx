package stx.assert.predicate.term;

class Always<T,E> extends Open<T,E>{
  override public function apply(v:T):Report<E>{
    return Report.unit();
  }
}