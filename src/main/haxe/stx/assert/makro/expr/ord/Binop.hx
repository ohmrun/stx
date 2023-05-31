package stx.assert.makro.expr.ord;

import haxe.macro.Expr.Binop as BinopT;

final Ord = __.assert().Ord();

class Binop extends OrdCls<BinopT>{
  public function new(){}
  public function comply(lhs:BinopT,rhs:BinopT){
    return switch([lhs,rhs]){
      case [OpAssignOp(opI),OpAssignOp(opII)]   : comply(opI,opII);
      default                                   : Ord.EnumValueIndex().comply(lhs,rhs); 
    }
  }
}