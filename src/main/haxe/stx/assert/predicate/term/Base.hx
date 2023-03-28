package stx.assert.predicate.term;

class Base<T> implements PredicateApi<T,AssertFailure> extends Clazz{
  var pos : Pos;
  public function new(?pos){
    super();
    this.pos = pos;
  }
  public function apply(v:T):Report<AssertFailure>{
    return None;
  }
  public function error(?l:T,?r:T){
    return __.fault(this.pos).of(PredicateFailed(this.definition(),l,r));
  }
}