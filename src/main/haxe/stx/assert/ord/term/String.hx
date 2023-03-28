package stx.assert.ord.term;

class String extends OrdCls<StdString>{
  public function new(){}
  public function comply(a:StdString,b:StdString):Ordered{
    return a < b ? LessThan : NotLessThan;
  }
}