package stx.assert.ord.term;

import haxe.ds.Map in StdMap;

class Map<K,V> extends OrdCls<StdMap<K,V>>{
  var key : Ord<K>;
  var val : Ord<V>;

  public function new(key,val){
    this.key = key;
    this.val = val;
  }
  public function comply(lhs:StdMap<K,V>,rhs:StdMap<K,V>):Ordered{
    var ret     = NotLessThan;
    var l_keys  = lhs.keys().toIter().toArray();
    var r_keys  = rhs.keys().toIter().toArray();
    var c       = l_keys.length - r_keys.length;
    return if(c != 0){
      c > 0 ? NotLessThan : LessThan;
    }else{
       ret = Ord.ArrayOrd(key).comply(l_keys,r_keys);
      if(ret == LessThan){
        LessThan;
      }else{
        for(k in l_keys){
          ret = val.comply(lhs.get(k),rhs.get(k));
          if(ret == LessThan){
            break;
          }
        }
      }
      ret;
    }
  }
}