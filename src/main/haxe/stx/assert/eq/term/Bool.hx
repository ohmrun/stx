package stx.assert.eq.term;

class Bool extends EqCls<StdBool>{
  public function new(){}
  public function comply(a:StdBool,b:StdBool):Equaled{
    return a == b ? AreEqual : NotEqual;
  }
}