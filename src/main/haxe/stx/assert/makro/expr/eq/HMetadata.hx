package stx.assert.makro.expr.eq;

import stx.makro.expr.HMetadata as THMetadata;

final Eq = __.assert().Eq();

class HMetadata extends stx.assert.eq.term.Base<THMetadata> {
  public function comply(lhs:THMetadata,rhs:THMetadata){
    return Eq.Array(Eq.Makro().Expr().HMetadataEntry).comply(lhs,rhs);
  }
}