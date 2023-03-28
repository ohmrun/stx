package stx.assert.ds.xset.comparable.term;

class XSetWith<K,V> extends ComparableCls<XSetValT<K,V>>{
  var self : XSetWithT<K,V>;
  public function new(self){
    this.self = self;
  }
  public function eq(){
    return new XSetWithEq(this.self);
  }
  public function lt(){
    return new XSetWithOrd(this.self);
  }
}