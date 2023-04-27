package stx.assert.glot.eq;

import eu.ohmrun.glot.expr.GStringLiteralKind as GStringLiteralKindT;

class GStringLiteralKind extends stx.assert.eq.term.Base<GStringLiteralKindT> {
  public function comply(lhs:GStringLiteralKindT,rhs:GStringLiteralKindT){
    return Eq.EnumValueIndex().comply(lhs,rhs);
  }
}