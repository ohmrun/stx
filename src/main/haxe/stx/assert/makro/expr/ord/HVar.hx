package stx.assert.makro.expr.ord;

import stx.makro.expr.HVar as HVarT;

final Ord = __.assert().Ord();

class HVar extends OrdCls<HVarT>{
  public function new(){}
  public function comply(lhs:HVarT,rhs:HVarT){
    var ord = Ord.String().comply(lhs.name,rhs.name);
    if(ord.is_not_less_than()){
      ord = Ord.NullOr(Ord.Makro().Expr().HComplexType).comply(lhs.type,rhs.type);
    }
    if(ord.is_not_less_than()){
      ord = Ord.NullOr(Ord.Makro().Expr().Expr).comply(lhs.expr,rhs.expr);
    }
    if(ord.is_not_less_than()){
      ord = Ord.NullOr(Ord.Makro().Expr().HMetadata).comply(lhs.meta,rhs.meta);
    }
    if(ord.is_not_less_than()){
      ord = Ord.NullOr(Ord.Bool()).comply(lhs.isFinal,rhs.isFinal);
    }
    if(ord.is_not_less_than()){
      ord = Ord.NullOr(Ord.Bool()).comply(lhs.isStatic,rhs.isStatic);
    }
    return ord;
  }
}