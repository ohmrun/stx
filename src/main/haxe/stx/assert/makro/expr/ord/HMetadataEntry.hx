package stx.assert.makro.expr.ord;

import stx.makro.expr.HMetadataEntry as HMetadataEntryT;

final Ord = __.assert().Ord();

class HMetadataEntry extends OrdCls<HMetadataEntryT>{
  public function new(){}
  public function comply(lhs:HMetadataEntryT,rhs:HMetadataEntryT){
    var ord = Ord.String().comply(lhs.name,rhs.name);
    if(ord.is_not_less_than()){
      ord = Ord.NullOr(Ord.Array(Ord.Makro().Expr().Expr)).comply(lhs.params,rhs.params);
    }
    return ord;
  }
}