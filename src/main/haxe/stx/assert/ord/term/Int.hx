package stx.assert.ord.term;

class Int extends OrdCls<StdInt>{
  public function new(){}
  public function comply(a:StdInt,b:StdInt):Ordered{
    return a < b ? LessThan : NotLessThan;
  }
}