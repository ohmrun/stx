package stx.assert.g.ord;

import stx.g.lang.expr.GStringLiteralKind as GStringLiteralKindT;

class GStringLiteralKind extends OrdCls<GStringLiteralKindT>{
  public function new(){}
  public function comply(lhs:GStringLiteralKindT,rhs:GStringLiteralKindT){
    return Ord.EnumValueIndex().comply(lhs,rhs);
  }
}