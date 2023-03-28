package stx.assert.assertion.term;

class Base<T> implements AssertionApi<T,AssertFailure> extends Clazz{
  var pos : Pos;
  public function new(?pos:Pos){
    super();
    this.pos = pos;
  }
  public function comply(a:T,b:T){
    return Report.unit();
  }
  public function error(?l,?r,?pos:Pos){
    return __.fault(pos).of(PredicateFailed(definition(),l,r));
  }
  public function asAssertionApi():AssertionApi<T,AssertFailure>{
    return this;
  }
}