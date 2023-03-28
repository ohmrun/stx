package stx.assert.predicate.term;

class Void<T> extends Base<T>{

  public function new(?pos){
    super(pos);
  }
  override public function apply(v:T){
    return (v == null).expect(error());
  }
}