package stx.assert.predicate.term;

class Never<T,E> extends Open<T,E>{

  public function new(?pos){
    super(pos);
  }
  override public function apply(v:T):Report<E>{
    return Report.pure(error());
  }
}