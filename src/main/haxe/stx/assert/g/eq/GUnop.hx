package stx.assert.g.eq;

import stx.g.lang.expr.GUnop as GUnopT;

class GUnop implements EqApi<GUnopT> extends Clazz{
  public function comply(lhs:GUnopT,rhs:GUnopT){
    return Eq.EnumValueIndex().comply(lhs,rhs);
  }
}