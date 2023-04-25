package stx.assert.eq.term;

class String extends EqCls<StdString>{
  public function new(){}
  public function comply(a:StdString,b:StdString):Equaled{
    return a == b ? AreEqual : NotEqual;
  }
}