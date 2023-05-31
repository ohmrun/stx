package stx.assert.makro.expr.eq;

import stx.makro.expr.HObjectField as THObjectField;

final Eq = __.assert().Eq();

class HObjectField extends stx.assert.eq.term.Base<THObjectField> {
  public function comply(lhs:THObjectField,rhs:THObjectField){
    var eq = Eq.String().comply(lhs.field,rhs.field);
    if(eq.is_ok()){
      eq = Eq.Makro().Expr().Expr.comply(lhs.expr,rhs.expr);
    }
    if(eq.is_ok()){
      eq = Eq.NullOr(Eq.Makro().Expr().QuoteStatus).comply(lhs.quotes,rhs.quotes);
    }
    return eq;
  }
} 