package stx.assert.makro.expr.eq;

import stx.makro.expr.HExprdef as THExprdef;
import stx.makro.expr.HExpr as THExpr;

final Eq = __.assert().Eq();

class HExpr extends EqCls<THExpr>{

  public function new(){}

  public function comply(a:THExpr,b:THExpr):Equaled{
    return Eq.Makro().Expr().HExprdef.comply(THExprdef.lift(a.expr),THExprdef.lift(b.expr));
  }
}