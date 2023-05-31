package stx.assert.makro.expr.eq;

import stx.makro.expr.HExprdef as THExprdef;
import haxe.macro.Expr as TExpr;

final Eq = __.assert().Eq();

class Expr extends EqCls<TExpr>{

  public function new(){}

  public function comply(a:TExpr,b:TExpr):Equaled{
    return Eq.Makro().Expr().HExprdef.comply(THExprdef.lift(a.expr),THExprdef.lift(b.expr));
  }
}