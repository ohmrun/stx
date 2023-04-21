package stx.assert.g.ord;

import stx.g.lang.expr.GMetadata as GMetadataT;

class GMetadata extends OrdCls<GMetadataT>{
  public function new(){}
  public function comply(lhs:GMetadataT,rhs:GMetadataT){
    return Ord.Cluster(new GMetadataEntry()).comply(lhs.prj(),rhs.prj());
  }
}