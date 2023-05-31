package stx.assert.makro.expr.eq;

import stx.makro.expr.HCase as THCase;

final Eq = __.assert().Eq();

class HCase extends EqCls<THCase>{

  public function new(){
  }

  public function comply(a:THCase,b:THCase):Equaled{
    var eq = Eq.Array(Eq.Makro().Expr().Expr).comply(a.values,b.values);
    if(eq.is_ok()){
      eq =  Eq.NullOr(Eq.Makro().Expr().Expr).comply(a.guard,b.guard);
    }
    if(eq.is_ok()){
      eq =  Eq.NullOr(Eq.Makro().Expr().Expr).comply(a.expr,b.expr);
    }
    return eq;
  }
}