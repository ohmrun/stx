package stx.assert.g.eq;

import stx.g.lang.expr.GPropAccess as GPropAccessT;

class GPropAccess implements EqApi<GPropAccessT> extends Clazz{
  public function comply(lhs:GPropAccessT,rhs:GPropAccessT){
    return Eq.EnumValueIndex().comply(lhs,rhs);
  }
}