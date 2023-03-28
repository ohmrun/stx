package stx.assert.assertion.term;

class Equals<T> extends Base<T>{
  public function new(?pos){
    super(pos);
  }

  override public function comply(a:T,b:T){
    return (a == b).expect(error());
  }
}