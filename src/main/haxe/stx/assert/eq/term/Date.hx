package stx.assert.eq.term;


class Date extends EqCls<StdDate>{
  public function new(){}
  public function comply(a:StdDate,b:StdDate):Equaled{
    return a.getTime() == b.getTime() ? AreEqual : NotEqual;
  }
}