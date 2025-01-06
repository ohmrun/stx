package stx.assert.assertion.term;

class Anon<T,E> implements AssertionApi<T,E>{
  final pos       : Pos;
  public function new(delegate,?pos:Pos){
    this.delegate = delegate;
    this.pos      = pos;
  }
  public dynamic function delegate(a:T,b:T):Report<E>{
    return Report.pure(__.fault().digest((_:Digests) -> _.e_unimplemented("delegate")));
  } 
  public function comply(a:T,b:T){
    return delegate(a,b);
  }
  public function asAssertionApi():AssertionApi<T,E>{
    return this;
  }
}