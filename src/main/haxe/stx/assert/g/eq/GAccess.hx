package stx.assert.g.eq;

import stx.g.lang.expr.GAccess as GAccessT;

class GAccess implements EqApi<GAccessT> extends Clazz{
  public function comply(lhs:GAccessT,rhs:GAccessT){
    return Eq.EnumValueIndex().comply(lhs,rhs);
  }
}