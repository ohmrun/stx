package stx.assert.eq.term;

class Null<T:Null<Dynamic>> implements EqApi<T> extends Clazz{
  public function comply(a:T,b:T):Equaled{
    return (a == null) && (b == null) ? AreEqual : NotEqual;
  }
}