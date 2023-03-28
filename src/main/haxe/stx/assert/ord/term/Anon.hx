package stx.assert.ord.term;

class Anon<T> extends OrdCls<T>{
  var delegate : T -> T -> Ordered;
  public function new(delegate){
    this.delegate = delegate;
  }
  public function comply(lhs:T,rhs:T):Ordered{
    return delegate(lhs,rhs);
  }
}