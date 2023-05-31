package stx.assert.makro.expr.eq;

import stx.makro.expr.HFunctionArg as HFunctionArgT;

final Eq = __.assert().Eq();

class HFunctionArg extends stx.assert.eq.term.Base<HFunctionArgT> {
  public function comply(lhs:HFunctionArgT,rhs:HFunctionArgT){
    var eq = Eq.String().comply(lhs.name,rhs.name);
    if(eq.is_ok()){
      eq = Eq.NullOr(Eq.Makro().Expr().HComplexType).comply(lhs.type,rhs.type);
    }
    if(eq.is_ok()){
      eq = Eq.NullOr(Eq.Bool()).comply(lhs.opt,rhs.opt);
    }
    if(eq.is_ok()){
      eq = Eq.NullOr(Eq.Makro().Expr().Expr).comply(lhs.value,rhs.value);
    }
    if(eq.is_ok()){
      eq = Eq.NullOr(Eq.Makro().Expr().HMetadata).comply(lhs.meta,rhs.meta);
    }
    return eq;
  }
}