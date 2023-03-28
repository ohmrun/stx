package stx.assert.ds.xset.ord.term;

class XSetVal<K,V> extends OrdCls<XSetValT<K,V>>{
  var val_comparable:Comparable<V>;
  public function new(val_comparable:Comparable<V>){
    this.val_comparable = val_comparable;
  }
  public function comply(a:XSetValT<K,V>,b:XSetValT<K,V>):Ordered{
    return switch([a,b]){
      case [SetVal(k,v),SetVal(k0,v0)]  : 
        val_comparable.lt().comply(v,v0);
      case [SetObj(k,v),SetObj(k0,v0)]  : 
        v.ltx(v0,new XSetValComparable(val_comparable));
      case [SetVal(_),SetObj(_)]        : 
        LessThan;
      case [SetObj(_),SetVal(_)]        : 
        NotLessThan;
    }
  }
}