package stx.assert.ord.term;

class String extends OrdCls<std.String>{
  public function new(){}
  public function comply(a:std.String,b:std.String):Ordered{
    return a < b ? LessThan : NotLessThan;
  }
}