package stx.assert.ord.term;

class Float extends OrdCls<StdFloat>{
  public function new(){}
  public function comply(a:StdFloat,b:StdFloat):Ordered{
    return a < b ? LessThan : NotLessThan;
  }
}