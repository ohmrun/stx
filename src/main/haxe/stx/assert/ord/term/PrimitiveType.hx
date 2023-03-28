package stx.assert.ord.term;

import stx.nano.PrimitiveType in TPrimitiveType;

class PrimitiveType extends OrdCls<TPrimitiveType>{
  public function new(){}
  public function comply(lhs:TPrimitiveType,rhs:TPrimitiveType){
    return switch([lhs,rhs]){
      case [PTBlob,PTBlob]          : NotLessThan;
      case [PTBool,PTBool]          : NotLessThan;
      case [PTInt,PTInt]            : NotLessThan;
      case [PTUint,PTUint]          : NotLessThan;
      case [PTFloat,PTFloat]        : NotLessThan;
      case [PTInt64,PTInt64]        : NotLessThan;
      case [PTText,PTText]          : NotLessThan;
      default                       : Ord.EnumValueIndex().comply(lhs,rhs);
    }
  }
}