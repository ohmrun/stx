package stx.assert.ord.term;

class Int64 extends OrdCls<haxe.Int64>{
  public function new(){}
  public function comply(a:haxe.Int64,b:haxe.Int64):Ordered{
    return a < b ? LessThan : NotLessThan;
  }
}