package stx.assert.makro.expr.ord;

import stx.makro.expr.HObjectField as HObjectFieldT;

final Ord = __.assert().Ord();

class HObjectField extends OrdCls<HObjectFieldT>{
  public function new(){}
  public function comply(lhs:HObjectFieldT,rhs:HObjectFieldT){
    var ord = Ord.String().comply(lhs.field,rhs.field);
    if(ord.is_not_less_than()){
      ord = Ord.Makro().Expr().Expr.comply(lhs.expr,rhs.expr);
    }
    if(ord.is_not_less_than()){
      ord = Ord.NullOr(new stx.assert.makro.expr.ord.QuoteStatus()).comply(lhs.quotes,rhs.quotes);
    }
    return ord;
  }
}