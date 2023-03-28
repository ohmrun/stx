package stx.assert.eq.term;

import stx.nano.KV as TKV;

class KV<L,R> extends EqCls<TKV<L,R>>{
  var key : Eq<L>;
  var val : Eq<R>;

  public function new(key,val){
    this.key = key;
    this.val = val;
  }
  public function comply(a:TKV<L,R>,b:TKV<L,R>):Equaled{
    var ord =  key.comply(a.key,b.key);
    if(ord.is_equal()) {
      ord = val.comply(a.val,b.val); 
    }
    return ord;
  }
}