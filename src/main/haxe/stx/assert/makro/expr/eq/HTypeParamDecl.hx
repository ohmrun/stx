package stx.assert.makro.expr.eq;

import stx.makro.expr.HTypeParamDecl as THTypeParamDecl;

final Eq = __.assert().Eq();

class HTypeParamDecl extends stx.assert.eq.term.Base<THTypeParamDecl> {
  public function comply(lhs:THTypeParamDecl,rhs:THTypeParamDecl){
    var eq = Eq.String().comply(lhs.name,rhs.name);
    if(eq.is_ok()){
      eq = Eq.NullOr(Eq.Array(Eq.Makro().Expr().HComplexType)).comply(lhs.constraints,rhs.constraints);
    }
    if(eq.is_ok()){
      eq = Eq.NullOr(Eq.Array(Eq.Makro().Expr().HTypeParamDecl)).comply(lhs.params,rhs.params);
    }
    if(eq.is_ok()){
      eq = Eq.NullOr(Eq.Makro().Expr().HMetadata).comply(lhs.meta,rhs.meta);
    }
    if(eq.is_ok()){
      eq = Eq.NullOr(Eq.Makro().Expr().HComplexType).comply(lhs.defaultType,rhs.defaultType);
    }
    return eq;
  }
}