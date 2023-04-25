package stx.assert.ds.xset.eq.term;

class XSet<K,V> extends EqCls<XSetVal<K,V>>{
  var with : With<K,V>;
  public function new(with){
    this.with = with;
  }
  public function comply(a:XSetVal<K,V>,b:XSetVal<K,V>):Equaled{
    return switch([a,b]){
      case [SetObj(k,v),SetObj(k0,v0)] :
        with.K.eq().comply(k,k0) && v.eqx(v0,new XSetComparable(with));
      case [SetVal(k,v),SetVal(k0,v0)] :
        with.K.eq().comply(k,k0) && with.V.eq().comply(v,v0);
      default : NotEqual;
    }
  }
}