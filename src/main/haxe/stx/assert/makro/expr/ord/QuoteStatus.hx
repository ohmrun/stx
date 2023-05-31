package stx.assert.makro.expr.ord;

import haxe.macro.Expr.QuoteStatus as TQuoteStatus;

final Ord = __.assert().Ord();

class QuoteStatus extends OrdCls<TQuoteStatus>{
  public function new(){}
  public function comply(lhs:TQuoteStatus,rhs:TQuoteStatus){
    return Ord.EnumValueIndex().comply(lhs,rhs);
  }
}