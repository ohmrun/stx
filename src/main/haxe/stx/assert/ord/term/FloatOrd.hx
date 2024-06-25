package stx.assert.ord.term;

class FloatOrd extends OrdCls<Float>{
  public function new(){}
  public function comply(a:Float,b:Float):Ordered{
    return a < b ? LessThan : NotLessThan;
  }
}