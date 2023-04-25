package stx.assert.eq.term;


class Int extends EqCls<StdInt>{
  public function new(){}
  public function comply(a:StdInt,b:StdInt):Equaled{
    return a == b ? AreEqual : NotEqual;
  }
}