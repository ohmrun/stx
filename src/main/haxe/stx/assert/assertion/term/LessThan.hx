package stx.assert.assertion.term;

class LessThan<T> extends Base<T>{
  public function new(?pos){
    super(pos);
  }
  override public function comply(a:T,b:T){
    var l : Dynamic = a;
    var r : Dynamic = b;
    return (l<r).expect(error());
  }
}