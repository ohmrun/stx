package stx.assert.makro.expr.ord;

import stx.makro.expr.HCatch as HCatchT;

final Ord = __.assert().Ord();

class HCatch extends OrdCls<HCatchT>{
  public function new(){}
  public function comply(lhs:HCatchT,rhs:HCatchT){
    var ord = Ord.String().comply(lhs.name,rhs.name);
    return if(ord.is_not_less_than()){
      ord = Ord.Makro().Expr().Expr.comply(lhs.expr,rhs.expr);
      if(ord.is_not_less_than()){
        ord = Ord.NullOr(Ord.Makro().Expr().HComplexType).comply(lhs.type,rhs.type);
      }
      ord;
    }else{
      ord;
    }
  }
}