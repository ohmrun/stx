package stx.assert.ds.xset.comparable.term;

class XSetVal<K,V> extends ComparableCls<XSetValT<K,V>>{
  var val_comparable:Comparable<V>;
  public function new(val_comparable){
    this.val_comparable = val_comparable;
  }
  public function lt():Ord<XSetValT<K,V>>{
    return new XSetValOrd(this.val_comparable);
  }
  public function eq():Eq<XSetValT<K,V>>{
    return new XSetValEq(this.val_comparable);
  }
}