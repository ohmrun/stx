package stx.assert.g.ord;

import stx.g.lang.expr.GBinop as GBinopT;

class GBinop extends OrdCls<GBinopT>{
  public function new(){}
  public function comply(lhs:GBinopT,rhs:GBinopT){
    return switch([lhs,rhs]){
      case [GOpAssignOp(opI),GOpAssignOp(opII)]   : comply(opI,opII);
      default                                     : Ord.EnumValueIndex().comply(lhs,rhs); 
    }
  }
}