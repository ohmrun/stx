package stx.assert.makro.expr.ord;

import stx.makro.expr.HFunction as HFunctionT;

final Ord = __.assert().Ord();

class HFunction extends OrdCls<HFunctionT>{
  public function new(){}
  public function comply(lhs:HFunctionT,rhs:HFunctionT){
    var ord = Ord.Array(Ord.Makro().Expr().HFunctionArg).comply(lhs.args,rhs.args);
    if(ord.is_not_less_than()){
      ord = Ord.NullOr(Ord.Makro().Expr().HComplexType).comply(lhs.ret,rhs.ret);
    }
    if(ord.is_not_less_than()){
      ord = Ord.NullOr(Ord.Makro().Expr().Expr).comply(lhs.expr,rhs.expr);
    }
    if(ord.is_not_less_than()){
      ord = Ord.NullOr(Ord.Array(Ord.Makro().Expr().HTypeParamDecl)).comply(lhs.params,rhs.params);
    }
    return ord;
  }
}