package stx.assert.g.ord;

import stx.g.lang.expr.GTypePath as GTypePathT;

class GTypePath extends OrdCls<GTypePathT>{
  public function new(){}
  public function comply(lhs:GTypePathT,rhs:GTypePathT){
    var ord = Ord.String().comply(lhs.name,rhs.name);
    if(ord.is_not_less_than()){
      ord = Ord.Cluster(Ord.String()).comply(lhs.pack,rhs.pack);
    }
    if(ord.is_not_less_than()){
      ord = Ord.NullOr(Ord.String()).comply(lhs.sub,rhs.sub);
    }
    if(ord.is_not_less_than()){
      ord = Ord.NullOr(Ord.Cluster(new GTypeParam())).comply(lhs.params,rhs.params);
    }
    return ord;
  }
}