package stx.assert.eq.term;

class HasFunction<T:{ equals: Dynamic->Bool }> implements EqApi<T> extends Clazz{
  public function comply(a:T,b:Dynamic):Equaled{
    return a.equals(b) ? AreEqual : NotEqual;
  }
  public function elide<U>():Eq<U>{ 
    return cast this;
  }
}