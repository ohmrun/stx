package stx.assert.eq.term;

class HasFunction<T:{ equals: Dynamic->Bool }> extends EqCls<T> {
  public function new(){}
  public function comply(a:T,b:T):Equaled{
    return a.equals(b) ? AreEqual : NotEqual;
  }
  public function elide<U>():Eq<U>{ 
    return cast this;
  }
}