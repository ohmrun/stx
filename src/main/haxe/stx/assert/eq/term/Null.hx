package stx.assert.eq.term;

class Null<T:Null<Dynamic>> extends EqCls<T>{
  public function new(){}
  public function comply(a:T,b:T):Equaled{
    return (a == null) && (b == null) ? AreEqual : NotEqual;
  }
}