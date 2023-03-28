package stx.assert.g.eq;

import stx.g.lang.expr.GMetadataEntry as GMetadataEntryT;

class GMetadataEntry implements EqApi<GMetadataEntryT> extends Clazz{
  public function comply(lhs:GMetadataEntryT,rhs:GMetadataEntryT){
    var eq = Eq.String().comply(lhs.name,rhs.name);
    if(eq.is_ok()){
      eq = Eq.NullOr(Eq.Cluster(new GExpr())).comply(lhs.params,rhs.params);
    }
    return eq;
  }
}