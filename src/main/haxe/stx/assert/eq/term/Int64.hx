package stx.assert.eq.term;

class Int64 implements EqApi<haxe.Int64> extends Clazz{
  public function comply(a:haxe.Int64,b:haxe.Int64):Equaled{
    return a == b ? AreEqual : NotEqual;
  }
}