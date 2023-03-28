package stx.assert.predicate.term;

class Or<T,E> extends Open<T,E>{
  var l : Predicate<T,E>;
  var r : Predicate<T,E>;

  public function new(l,r,?pos){
    super(pos);
    this.l = l;
    this.r = r;
  }
  override public function apply(v:T):Report<E>{
    var resI  = l.apply(v);
    var resII = r.apply(v);
    return if(resI.is_defined() && resII.is_defined()){
      resI.concat(resII);
    }else{
      Report.unit();
    }
  }
}