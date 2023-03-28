package stx.assert.eq.term;

class Lazy<T> extends EqCls<T>{
  public var delegate : T -> T -> Equaled;
  public function new(?self){
    this.delegate = self;
  }
  public function comply(lhs:T,rhs:T):Equaled{
    return this.delegate(lhs,rhs);
  }
}