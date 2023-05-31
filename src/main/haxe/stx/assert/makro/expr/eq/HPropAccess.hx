package stx.assert.makro.expr.eq;

import stx.makro.expr.HPropAccess as HPropAccessT;

final Eq = __.assert().Eq();

class HPropAccess extends stx.assert.eq.term.Base<HPropAccessT> {
  public function comply(lhs:HPropAccessT,rhs:HPropAccessT){
    return Eq.String().comply(lhs,rhs);
  }
}