package stx.assert.makro.expr.ord;

import stx.makro.expr.HExprdef as THExprdef;
import stx.makro.expr.HExpr as THExpr;

final Ord = __.assert().Ord();

class HExpr extends OrdCls<THExpr>{

  public function new(){}

  public function comply(a:THExpr,b:THExpr):Ordered{
    return Ord.Makro().Expr().HExprdef.comply(THExprdef.lift(a.expr),THExprdef.lift(b.expr));
  }
}