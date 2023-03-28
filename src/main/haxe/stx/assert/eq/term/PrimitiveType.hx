package stx.assert.eq.term;

import stx.nano.PrimitiveType in TPrimitiveType;

class PrimitiveType extends EqCls<TPrimitiveType>{
  public function new(){}
  public function comply(lhs:TPrimitiveType,rhs:TPrimitiveType){
    return switch([lhs,rhs]){
      case [PTBlob,PTBlob]          : AreEqual;
      case [PTBool,PTBool]          : AreEqual;
      case [PTInt,PTInt]            : AreEqual;
      case [PTUint,PTUint]          : AreEqual;
      case [PTFloat,PTFloat]        : AreEqual;
      case [PTInt64,PTInt64]        : AreEqual;
      case [PTText,PTText]          : AreEqual;
      default                       : Eq.EnumValueIndex().comply(lhs,rhs);
    }
  }
}