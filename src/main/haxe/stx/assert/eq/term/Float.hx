package stx.assert.eq.term;

class Float extends EqCls<StdFloat>{
  public function new(){}
  public function comply(a:StdFloat,b:StdFloat):Equaled{
    return a == b ? AreEqual : NotEqual;
  }
}