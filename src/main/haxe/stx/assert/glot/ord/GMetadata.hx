package stx.assert.glot.ord;

import eu.ohmrun.glot.expr.GMetadata as GMetadataT;

class GMetadata extends OrdCls<GMetadataT>{
  public function new(){}
  public function comply(lhs:GMetadataT,rhs:GMetadataT){
    return Ord.Cluster(new GMetadataEntry()).comply(lhs.prj(),rhs.prj());
  }
}