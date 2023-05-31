package stx.assert.eq.term;

import haxe.ds.Map as StdMap;

class Map<K,V> extends EqCls<StdMap<K,V>>{
  var eq : Eq<V>;

  public function new(eq){
    this.eq = eq;
  }
  public function comply(a:StdMap<K,V>,b:StdMap<K,V>):Equaled{
    var ok = true;

    for(key => val in a){
      if(!b.exists(key)){
        break;
      }
      ok = eq.comply(val,b.get(key)).toBool();

      if(!ok){break;}
    }
    for(key => val in b){
      if(!a.exists(key)){
        ok = false;
        break;
      }
    }
    return ok ? AreEqual : NotEqual;
  }
}