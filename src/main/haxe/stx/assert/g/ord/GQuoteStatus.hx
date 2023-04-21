package stx.assert.g.ord;

import stx.g.lang.expr.GQuoteStatus as GQuoteStatusT;

class GQuoteStatus extends OrdCls<GQuoteStatusT>{
  public function new(){}
  public function comply(lhs:GQuoteStatusT,rhs:GQuoteStatusT){
    return Ord.EnumValueIndex().comply(lhs,rhs);
  }
}