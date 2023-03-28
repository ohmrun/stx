package stx.assert.eq.term;

class Bool implements EqApi<StdBool> extends Clazz{
  public function comply(a:StdBool,b:StdBool):Equaled{
    return a == b ? AreEqual : NotEqual;
  }
}