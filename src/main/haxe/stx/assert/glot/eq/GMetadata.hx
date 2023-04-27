package stx.assert.glot.eq;

import eu.ohmrun.glot.expr.GMetadata as GMetadataT;

class GMetadata extends stx.assert.eq.term.Base<GMetadataT> {
  public function comply(lhs:GMetadataT,rhs:GMetadataT){
    return Eq.Cluster(new GMetadataEntry()).comply(lhs,rhs);
  }
}