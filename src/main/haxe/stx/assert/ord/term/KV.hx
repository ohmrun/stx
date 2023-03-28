package stx.assert.ord.term;

import stx.nano.KV as TKV;

class KV<L,R> extends OrdCls<TKV<L,R>>{
  var key : Ord<L>;
  var val : Ord<R>;

  public function new(key,val){
    this.key = key;
    this.val = val;
  }
  public function comply(a:TKV<L,R>,b:TKV<L,R>):Ordered{
    return key.comply(a.key,b.key) && val.comply(a.val,b.val); 
  }
}