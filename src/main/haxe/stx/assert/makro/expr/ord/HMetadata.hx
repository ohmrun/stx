package stx.assert.makro.expr.ord;

import stx.makro.expr.HMetadata as HMetadataT;

final Ord = __.assert().Ord();

class HMetadata extends OrdCls<HMetadataT>{
  public function new(){}
  public function comply(lhs:HMetadataT,rhs:HMetadataT){
    return Ord.Array(Ord.Makro().Expr().HMetadataEntry).comply(lhs.prj(),rhs.prj());
  }
}