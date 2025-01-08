package stx.assert.ds.xset.comparable.term;

class XSetKey<K,V> extends ComparableCls<XSetVal<K,V>>{
  var key_comparable : Comparable<K>;

  public function new(key_comparable){
    this.key_comparable = key_comparable;
  }
  public function eq():Eq<XSetVal<K,V>>{
    return new XSetKeyEq(key_comparable);
  }
  public function lt():Ord<XSetVal<K,V>>{
    return new XSetKeyOrd(key_comparable);
  }
}