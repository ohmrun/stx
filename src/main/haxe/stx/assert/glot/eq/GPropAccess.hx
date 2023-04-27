package stx.assert.glot.eq;

import eu.ohmrun.glot.expr.GPropAccess as GPropAccessT;

class GPropAccess extends stx.assert.eq.term.Base<GPropAccessT> {
  public function comply(lhs:GPropAccessT,rhs:GPropAccessT){
    return Eq.EnumValueIndex().comply(lhs,rhs);
  }
}