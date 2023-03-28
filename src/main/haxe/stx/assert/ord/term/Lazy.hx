package stx.assert.ord.term;

class Lazy<T> extends OrdCls<T>{
  public var delegate : T -> T -> Ordered;
  public function new(?self){
    this.delegate = self;
  }
  public function comply(lhs:T,rhs:T):Ordered{
    return this.delegate(lhs,rhs);
  }
}