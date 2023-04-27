package stx.assert.glot.ord;

import eu.ohmrun.glot.expr.GUnop as GUnopT;

class GUnop extends OrdCls<GUnopT>{
  public function new(){}
  public function comply(lhs:GUnopT,rhs:GUnopT){
    return Ord.EnumValueIndex().comply(lhs,rhs);
  }
}