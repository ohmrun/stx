package stx.assert.g.eq;

import stx.g.lang.expr.GStringLiteralKind as GStringLiteralKindT;

class GStringLiteralKind implements EqApi<GStringLiteralKindT> extends Clazz{
  public function comply(lhs:GStringLiteralKindT,rhs:GStringLiteralKindT){
    return Eq.EnumValueIndex().comply(lhs,rhs);
  }
}