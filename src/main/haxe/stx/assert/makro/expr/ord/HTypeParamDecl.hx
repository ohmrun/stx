package stx.assert.makro.expr.ord;

import stx.makro.expr.HTypeParamDecl as HTypeParamDeclT;

final Ord = __.assert().Ord();

class HTypeParamDecl extends OrdCls<HTypeParamDeclT>{
  public function new(){}
  public function comply(lhs:HTypeParamDeclT,rhs:HTypeParamDeclT){
    var ord = Ord.String().comply(lhs.name,rhs.name);
    if(ord.is_not_less_than()){
      ord = Ord.NullOr(Ord.Array(Ord.Makro().Expr().HComplexType)).comply(lhs.constraints,rhs.constraints);
    }
    if(ord.is_not_less_than()){
      ord = Ord.NullOr(Ord.Array(Ord.Makro().Expr().HTypeParamDecl)).comply(lhs.params,rhs.params);
    }
    if(ord.is_not_less_than()){
      ord = Ord.NullOr(Ord.Makro().Expr().HMetadata).comply(lhs.meta,rhs.meta);
    }
    if(ord.is_not_less_than()){
      ord = Ord.NullOr(Ord.Makro().Expr().HComplexType).comply(lhs.defaultType,rhs.defaultType);
    }
    return ord;
  }
}