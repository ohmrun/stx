package stx.assert.ord.term;

class EnumValueIndex extends OrdCls<StdEnumValue>{
  public function new(){}
  public function comply(lhs:StdEnumValue,rhs:StdEnumValue){
    final l = lhs.lift();
    final r = rhs.lift();
    return l.index < r.index ? LessThan : NotLessThan; 
  }
}