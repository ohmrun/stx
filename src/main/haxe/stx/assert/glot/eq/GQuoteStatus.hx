package stx.assert.glot.eq;

import eu.ohmrun.glot.expr.GQuoteStatus as GQuoteStatusT;

class GQuoteStatus extends stx.assert.eq.term.Base<GQuoteStatusT> {
  public function comply(lhs:GQuoteStatusT,rhs:GQuoteStatusT){
    return Eq.EnumValueIndex().comply(lhs,rhs);
  }
}