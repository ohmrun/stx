package stx.assert.predicate.term;

class Transform<T,E,EE> extends Open<T,EE>{
  var transform : Refuse<E> -> Refuse<EE>;
  var delegate  : Predicate<T,E>;
  public function new(delegate,transform,?pos){
    super(pos);
    this.transform = transform;
    this.delegate  = delegate; 
  }
  override public function apply(v:T):Report<EE>{
    return delegate.apply(v).errata(transform);
  }
}