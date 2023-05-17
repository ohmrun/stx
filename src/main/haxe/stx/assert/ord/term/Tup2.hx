package stx.assert.ord.term;

import stx.Nano.Tup2 as TTup2;

class Tup2<L,R> extends OrdCls<TTup2<L,R>>{
  var l : Ord<L>;
  var r : Ord<R>;

  public function new(l,r){
    this.l = l;
    this.r = r;
  }
  public function comply(a:TTup2<L,R>,b:TTup2<L,R>):Ordered{
    return a.detuple((l0,r0) -> b.detuple((l1,r1)-> l.comply(l0,l1) || r.comply(r0,r1)));
  }
}