package stx.assert.eq.term;

class NullOr<T> extends EqCls<Null<T>>{
  final inner : Eq<T>;
  public function new(inner:Eq<T>){
    this.inner = inner;
  }
  
  public function comply(lhs:Null<T>,rhs:Null<T>){
    return if (lhs == null && rhs == null){
      AreEqual;
    }else if (lhs == null || rhs == null){
      NotEqual;
    }else{
      inner.comply(lhs,rhs);
    }
  }
}