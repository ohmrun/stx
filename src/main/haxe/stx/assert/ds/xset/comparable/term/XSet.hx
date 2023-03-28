package stx.assert.ds.xset.comparable.term;

class XSet<K,V> extends ComparableCls<XSetValT<K,V>>{
  var with : With<K,V>;
  public function new(with){
    this.with = with;
  }
  public function eq(){
    return new stx.assert.ds.xset.eq.term.XSet(this.with);
  }
  public function lt(){
    return new stx.assert.ds.xset.ord.term.XSet(this.with);
  }
}