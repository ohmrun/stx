package stx.assert.eq.term;

/**
  Pays no attention to parameters.
**/
class EnumValueIndex extends EqCls<StdEnumValue>{
  public function new(){}
  public function comply(lhs:StdEnumValue,rhs:StdEnumValue){
    final l = lhs.lift();
    final r = rhs.lift();
    return l.index == r.index ? AreEqual : NotEqual; 
  }
}