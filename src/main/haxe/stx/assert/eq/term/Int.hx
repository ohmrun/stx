package stx.assert.eq.term;


class Int implements EqApi<StdInt> extends Clazz{
  public function comply(a:StdInt,b:StdInt):Equaled{
    return a == b ? AreEqual : NotEqual;
  }
}