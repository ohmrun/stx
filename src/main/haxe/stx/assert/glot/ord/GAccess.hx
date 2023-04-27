package stx.assert.glot.ord;

import eu.ohmrun.glot.expr.GAccess as GAccessT;

class GAccess extends OrdCls<GAccessT>{
  public function new(){}
  public function comply(lhs:GAccessT,rhs:GAccessT){
    return Ord.EnumValueIndex().comply(lhs,rhs);
  }
}