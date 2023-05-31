package stx.assert.makro.expr.ord;

import haxe.macro.Expr in TExpr;
import stx.makro.expr.HExpr as THExpr;
import stx.makro.expr.HExprdef as THExprdef;

final Ord = __.assert().Ord();

class Expr extends OrdCls<TExpr>{
  public function new(){}
  public function comply(lhs:TExpr,rhs:TExpr):Ordered{
    return Ord.Makro().Expr().HExprdef.comply(THExprdef.lift(lhs.expr),THExprdef.lift(rhs.expr));
  }
}
