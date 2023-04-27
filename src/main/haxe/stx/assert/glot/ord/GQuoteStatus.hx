package stx.assert.glot.ord;

import eu.ohmrun.glot.expr.GQuoteStatus as GQuoteStatusT;

class GQuoteStatus extends OrdCls<GQuoteStatusT>{
  public function new(){}
  public function comply(lhs:GQuoteStatusT,rhs:GQuoteStatusT){
    return Ord.EnumValueIndex().comply(lhs,rhs);
  }
}