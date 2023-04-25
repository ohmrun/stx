package stx.assert.ds.xset.eq.term;

class XSetWith<K,V> extends EqCls<XSetValT<K,V>>{
  var self : XSetWithT<K,V>;
  public function new(self){
    this.self = self;
  }
  public function comply(a:XSetValT<K,V>,b:XSetValT<K,V>):Equaled{
    return switch(self.state){
      case CKey     : XSetWithT.key(self.with.K).eq().comply(a,b);
      case CVal     : XSetWithT.val(self.with.V).eq().comply(a,b);
      case CKeyVal  : XSetWithT.kv(self.with).eq().comply(a,b);
    }
  }
}