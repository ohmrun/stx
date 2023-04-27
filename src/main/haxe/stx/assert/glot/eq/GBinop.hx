package stx.assert.glot.eq;

import eu.ohmrun.glot.expr.GBinop as GBinopT;

class GBinop extends stx.assert.eq.term.Base<GBinopT> {
  public function comply(lhs:GBinopT,rhs:GBinopT){
    return switch([lhs,rhs]){
      case [GOpAssignOp(opI),GOpAssignOp(opII)]   : comply(opI,opII);
      default                                     : Eq.EnumValueIndex().comply(lhs,rhs); 
    }
  }
}