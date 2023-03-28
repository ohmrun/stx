package stx.assert.eq.term;

class String implements EqApi<StdString> extends Clazz{
  public function comply(a:StdString,b:StdString):Equaled{
    return a == b ? AreEqual : NotEqual;
  }
}