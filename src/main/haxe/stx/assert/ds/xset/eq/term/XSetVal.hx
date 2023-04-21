package stx.assert.ds.xset.eq.term;


class XSetVal<K,V> implements EqApi<XSetValT<K,V>>{
  var val_comparable:Comparable<V>;
  public function new(val_comparable:Comparable<V>){
    this.val_comparable = val_comparable;
  }
  public function comply(a:XSetValT<K,V>,b:XSetValT<K,V>):Equaled{
    return switch([a,b]){
      case [SetObj(k,v),SetObj(k0,v0)] :
        var out = v.eqx(v0,new XSetValComparable(this.val_comparable));
        out;
      case [SetVal(k,v),SetVal(k0,v0)] :
        val_comparable.eq().comply(v,v0);
      default : 
        NotEqual;
    }
  }
}