package stx.makro.expr.lift;

class LiftConstantToHExpr{
  static public function toHExpr(self:Constant,?pos:Position):HExpr{
    return new stx.makro.expr.HExprdef(EConst(self)).to_macro_at(pos);
  }
}