package stx.assert.predicate.term;

class Exists<T> extends Base<T>{
  public function new(?pos){
    super(pos);
  }
  override public function apply(v:T){
    var bool = __.option(v).map(_ -> true).defv(false);
    return bool.expect(this.error());
  }
}