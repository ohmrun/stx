package stx.assert.glot.ord;

import eu.ohmrun.glot.expr.GStringLiteralKind as GStringLiteralKindT;

class GStringLiteralKind extends OrdCls<GStringLiteralKindT>{
  public function new(){}
  public function comply(lhs:GStringLiteralKindT,rhs:GStringLiteralKindT){
    return Ord.EnumValueIndex().comply(lhs,rhs);
  }
}