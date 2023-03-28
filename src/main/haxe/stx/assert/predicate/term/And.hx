package stx.assert.predicate.term;

class And<T,E> extends Open<T,E>{
  var l : Predicate<T,E>;
  var r : Predicate<T,E>;

  public function new(l,r,?pos){
    super(pos);
    this.l = l;
    this.r = r;
  }
  override public function apply(v:T):Report<E>{
    var lr = l.apply(v);
    var rr = Report.unit();

    if(!lr.is_defined()){
       rr = r.apply(v);
    }

    return lr.concat(rr);
  }
}