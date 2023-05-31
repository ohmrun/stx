package stx.assert.makro.expr.eq;

import haxe.macro.Expr.Binop as TBinop;

final Eq = __.assert().Eq();

class Binop extends stx.assert.eq.term.Base<TBinop> {
  public function comply(lhs:TBinop,rhs:TBinop){
    return switch([lhs,rhs]){
      case [OpAssignOp(opI),OpAssignOp(opII)]     : comply(opI,opII);
      default                                     : Eq.EnumValueIndex().comply(lhs,rhs); 
    }
  }
}