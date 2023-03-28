package stx.assert.comparable.term;

class KV<L,R> extends ComparableCls<stx.nano.KV<L,R>>{
  var l : Comparable<L>;
  var r : Comparable<R>;

  public function new(l,r){
    this.l = l;
    this.r = r;
  }
  public function eq() : Eq<stx.nano.KV<L,R>>{
    return Eq.KV(l.eq(),r.eq());
  }
  public function lt() : Ord<stx.nano.KV<L,R>>{
    return Ord.KV(l.lt(),r.lt());
  }
}
