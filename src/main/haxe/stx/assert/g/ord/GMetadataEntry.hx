package stx.assert.g.ord;

import stx.g.lang.expr.GMetadataEntry as GMetadataEntryT;

class GMetadataEntry extends OrdCls<GMetadataEntryT>{
  public function new(){}
  public function comply(lhs:GMetadataEntryT,rhs:GMetadataEntryT){
    var ord = Ord.String().comply(lhs.name,rhs.name);
    if(ord.is_not_less_than()){
      ord = Ord.NullOr(Ord.Cluster(new GExpr())).comply(lhs.params,rhs.params);
    }
    return ord;
  }
}