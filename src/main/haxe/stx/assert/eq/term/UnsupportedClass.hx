package stx.assert.eq.term;

class UnsupportedClass<T> implements EqApi<T> extends Clazz{
  public function comply(a:T,b:T){
    return new Object().comply(a,b) && (StdType.getClass(a) == StdType.getClass(b) ? AreEqual : NotEqual);
  }
}