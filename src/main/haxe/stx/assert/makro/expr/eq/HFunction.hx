package stx.assert.makro.expr.eq;

import stx.makro.expr.HFunction as THFunction;

final Eq = __.assert().Eq();

class HFunction extends stx.assert.eq.term.Base<THFunction> {
  public function comply(lhs:THFunction,rhs:THFunction){
    var eq = Eq.Array(Eq.Makro().Expr().HFunctionArg).comply(lhs.args,rhs.args);
    if(eq.is_ok()){
      eq = Eq.NullOr(Eq.Makro().Expr().HComplexType).comply(lhs.ret,rhs.ret);
    }
    if(eq.is_ok()){
      eq = Eq.NullOr(Eq.Makro().Expr().Expr).comply(lhs.expr,rhs.expr);
    }
    if(eq.is_ok()){
      eq = Eq.NullOr(Eq.Array(Eq.Makro().Expr().HTypeParamDecl)).comply(lhs.params,rhs.params);
    }
    return eq;
  }
}