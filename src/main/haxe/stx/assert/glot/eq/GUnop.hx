package stx.assert.glot.eq;

import eu.ohmrun.glot.expr.GUnop as GUnopT;

class GUnop extends stx.assert.eq.term.Base<GUnopT> {
  public function comply(lhs:GUnopT,rhs:GUnopT){
    return Eq.EnumValueIndex().comply(lhs,rhs);
  }
}