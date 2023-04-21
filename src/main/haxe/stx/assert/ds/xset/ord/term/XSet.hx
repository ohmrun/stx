package stx.assert.ds.xset.ord.term;

class XSet<K,V> extends OrdCls<XSetValT<K,V>>{
  var with : With<K,V>;
  public function new(with){
    this.with = with;
  }
  public function comply(a:XSetValT<K,V>,b:XSetValT<K,V>):Ordered{
    return switch([a,b]){
      case [SetVal(k,v),SetVal(k0,v0)]  : 
        with.K.lt().comply(k,k0) || with.V.lt().comply(v,v0);
      case [SetObj(k,v),SetObj(k0,v0)]  : 
        with.K.lt().comply(k,k0) || v.ltx(v0,new stx.assert.ds.xset.comparable.term.XSet(with));
      case [SetVal(_),SetObj(_)]        : 
        LessThan;
      case [SetObj(_),SetVal(_)]        : 
        NotLessThan;
    }
  }
}