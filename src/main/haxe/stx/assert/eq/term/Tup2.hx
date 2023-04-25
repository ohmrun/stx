package stx.assert.eq.term;

import stx.Nano.Tup2 as TTup2;

class Tup2<L,R> extends EqCls<TTup2<L,R>>{
  var l : Eq<L>;
  var r : Eq<R>;

  public function new(l,r){
    this.l = l;
    this.r = r;
  }

  public function comply(a:TTup2<L,R>,b:TTup2<L,R>):Equaled {
    return switch([a,b]){
      case [tuple2(lI,rI),tuple2(lII,rII)] : l.comply(lI,lII) && r.comply(rI,rII);
    }
  }
}