package stx.assert.eq.term;

class Anon<T> extends EqCls<T>{
  var delegate : T -> T -> Equaled;
  public function new(self){
    this.delegate = self;
  }
  public function comply(lhs:T,rhs:T):Equaled{
    return this.delegate(lhs,rhs);
  }
}