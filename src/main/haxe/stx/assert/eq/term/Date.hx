package stx.assert.eq.term;


class Date implements EqApi<StdDate> extends Clazz{
  public function comply(a:StdDate,b:StdDate):Equaled{
    return a.getTime() == b.getTime() ? AreEqual : NotEqual;
  }
}