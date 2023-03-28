package stx.assert.predicate.term;

class Natural<T> extends Base<T>{
  var method : T -> Bool;
  public function new(method:T->Bool,?pos){
    this.method = method;
    super(pos);
  }
  override public function apply(v:T):Report<AssertFailure>{
    return method(v) ? Report.unit() : Report.pure(error());
  }
}