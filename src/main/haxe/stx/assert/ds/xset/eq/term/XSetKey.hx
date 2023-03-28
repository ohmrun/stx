package stx.assert.ds.xset.eq.term;

class XSetKey<K,V> implements EqApi<XSetValT<K,V>>{
  var key_comparable:Comparable<K>;
  public function new(key_comparable){
    this.key_comparable = key_comparable;
  }
  public function comply(a:XSetValT<K,V>,b:XSetValT<K,V>){
    return switch([a,b]){
      case [SetObj(k,_),SetObj(k0,_)] :
        key_comparable.eq().comply(k,k0);
      case [SetVal(k,_),SetVal(k0,_)] :
        key_comparable.eq().comply(k,k0);
      case [SetVal(k,_),SetObj(k0,_)] : 
        key_comparable.eq().comply(k,k0);
      case [SetObj(k,_),SetVal(k0,_)] :
        key_comparable.eq().comply(k,k0);
      default : 
        NotEqual;
    }
  }
}