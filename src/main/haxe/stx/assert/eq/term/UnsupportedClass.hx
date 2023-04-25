package stx.assert.eq.term;

class UnsupportedClass<T> extends EqCls<T>{
  public function new(){}
  public function comply(a:T,b:T){
    return new Object().comply(a,b) && (StdType.getClass(a) == StdType.getClass(b) ? AreEqual : NotEqual);
  }
}