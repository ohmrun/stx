package stx.assert.makro.expr.ord;

import stx.makro.expr.HQuoteStatus as THQuoteStatus;

final Ord = __.assert().Ord();

class HQuoteStatus extends OrdCls<THQuoteStatus>{
  public function new(){}
  public function comply(lhs:THQuoteStatus,rhs:THQuoteStatus){
    return Ord.EnumValueIndex().comply(lhs,rhs);
  }
}