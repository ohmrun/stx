package stx.assert.predicate.term;

class Not<T,E> extends Open<T,E>{
  var predicate : Predicate<T,E>;
  
  public function new(predicate,?pos){
    super(pos);
    this.predicate = predicate;
  }
  override public function apply(v:T){
    var bool = predicate.apply(v).fold(
      (c) -> true,
      () -> false
    );
    return bool.expect(error());
  }
}