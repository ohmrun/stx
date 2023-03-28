package stx.assert.g.eq;

import stx.g.lang.expr.GQuoteStatus as GQuoteStatusT;

class GQuoteStatus implements EqApi<GQuoteStatusT> extends Clazz{
  public function comply(lhs:GQuoteStatusT,rhs:GQuoteStatusT){
    return Eq.EnumValueIndex().comply(lhs,rhs);
  }
}