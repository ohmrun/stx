package stx.assert.makro.expr.eq;

import stx.makro.expr.HQuoteStatus as THQuoteStatus;

final Eq = __.assert().Eq();

class HQuoteStatus extends EqCls<THQuoteStatus> {
  public function new(){}
  public function comply(lhs:THQuoteStatus,rhs:THQuoteStatus){
    return Eq.EnumValueIndex().comply(lhs,rhs);
  }
}