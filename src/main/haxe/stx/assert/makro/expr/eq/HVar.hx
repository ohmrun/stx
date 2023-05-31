package stx.assert.makro.expr.eq;

import stx.makro.expr.HVar as HVarT;

final Eq = __.assert().Eq();

class HVar extends stx.assert.eq.term.Base<HVarT> {
  public function comply(lhs:HVarT,rhs:HVarT){
    var eq = Eq.String().comply(lhs.name,rhs.name);
    if(eq.is_ok()){
      eq = Eq.NullOr(Eq.Makro().Expr().HComplexType).comply(lhs.type,rhs.type);
    }
    if(eq.is_ok()){
      eq = Eq.NullOr(Eq.Makro().Expr().Expr).comply(lhs.expr,rhs.expr);
    }
    if(eq.is_ok()){
      eq = Eq.NullOr(Eq.Makro().Expr().HMetadata).comply(lhs.meta,rhs.meta);
    }
    if(eq.is_ok()){
      eq = Eq.NullOr(Eq.Bool()).comply(lhs.isFinal,rhs.isFinal);
    }
    if(eq.is_ok()){
      eq = Eq.NullOr(Eq.Bool()).comply(lhs.isStatic,rhs.isStatic);
    }
    return eq;
  }
}