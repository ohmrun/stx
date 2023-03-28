package stx.assert.g.eq;

import stx.g.lang.expr.GBinop as GBinopT;

class GBinop implements EqApi<GBinopT> extends Clazz{
  public function comply(lhs:GBinopT,rhs:GBinopT){
    return switch([lhs,rhs]){
      case [GOpAssignOp(opI),GOpAssignOp(opII)]   : comply(opI,opII);
      default                                     : Eq.EnumValueIndex().comply(lhs,rhs); 
    }
  }
}