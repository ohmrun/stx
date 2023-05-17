package stx.assert.eq.term;

import stx.nano.EnumValue as TEnumValue;
/**
  Pays no attention to parameters.
**/
class EnumValueIndex extends EqCls<StdEnumValue>{
  public function new(){}
  public function comply(lhs:StdEnumValue,rhs:StdEnumValue){
    final l = TEnumValue.lift(lhs);
    final r = TEnumValue.lift(rhs);
    return l.index == r.index ? AreEqual : NotEqual; 
  }
}