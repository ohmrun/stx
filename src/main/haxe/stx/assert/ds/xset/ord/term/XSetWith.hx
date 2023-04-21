package stx.assert.ds.xset.ord.term;

class XSetWith<K,V> extends OrdCls<XSetValT<K,V>>{
  var self : XSetWithT<K,V>;
  public function new(self){
    this.self = self;
  }
  public function comply(a:XSetValT<K,V>,b:XSetValT<K,V>):Ordered{
    return switch(self.state){
      case CKey     : XSetWithT.key(self.with.K).lt().comply(a,b);
      case CVal     : XSetWithT.val(self.with.V).lt().comply(a,b);
      case CKeyVal  : XSetWithT.kv(self.with).lt().comply(a,b);
    }
  }
}