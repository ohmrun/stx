package stx.assert.makro.expr.eq;

import haxe.macro.Expr.Metadata as TMetadata;

final Eq = __.assert().Eq();

class Metadata extends stx.assert.eq.term.Base<TMetadata> {
  public function comply(lhs:TMetadata,rhs:TMetadata){
    return Eq.Array(Eq.Makro().Expr().HMetadataEntry).comply(lhs,rhs);
  }
}