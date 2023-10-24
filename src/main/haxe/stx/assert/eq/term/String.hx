package stx.assert.eq.term;

class String extends EqCls<std.String>{
  static public function Unit(){
    return new String();
  }
  public function new(){}
  public function comply(a:std.String,b:std.String):Equaled{
    return a == b ? AreEqual : NotEqual;
  }
}