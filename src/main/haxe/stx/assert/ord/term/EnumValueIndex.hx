package stx.assert.ord.term;

import stx.nano.EnumValue as TEnumValue;

class EnumValueIndex extends OrdCls<StdEnumValue>{
  public function new(){}
  public function comply(lhs:StdEnumValue,rhs:StdEnumValue){
    final l = TEnumValue.lift(lhs);
    final r = TEnumValue.lift(rhs);
    return l.index < r.index ? LessThan : NotLessThan; 
  }
}