package stx.assert.ord.term;

import stx.nano.Ident in IdentT;

class Ident extends OrdCls<IdentT>{
  public function new(){}
  public function comply(thiz:IdentT,that:IdentT){
    var ord = Ord.String().comply(thiz.name,that.name);
    if(ord.is_not_less_than()){
      ord = Ord.NullOr(Ord.Cluster(Ord.String())).comply(thiz.pack,that.pack);
    }
    return ord;
  }
}