package stx.assert.eq.term;

/**
  Pays no attention to parameters.
**/
class EnumValueIndex implements EqApi<StdEnumValue> extends Clazz{
  public function comply(lhs:StdEnumValue,rhs:StdEnumValue){
    final l = lhs.lift();
    final r = rhs.lift();
    return l.index == r.index ? AreEqual : NotEqual; 
  }
}