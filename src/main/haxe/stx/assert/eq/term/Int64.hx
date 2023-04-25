package stx.assert.eq.term;

class Int64 extends EqCls<haxe.Int64>{
  public function new(){}
  public function comply(a:haxe.Int64,b:haxe.Int64):Equaled{
    return a == b ? AreEqual : NotEqual;
  }
}