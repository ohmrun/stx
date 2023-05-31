package stx.assert.makro.expr.eq;

import stx.makro.expr.HAccess as THAccess;

final Eq = __.assert().Eq();

class HAccess extends stx.assert.eq.term.Base<THAccess> {
  public function comply(lhs:THAccess,rhs:THAccess){
    return Eq.EnumValueIndex().comply(lhs,rhs);
  }
}