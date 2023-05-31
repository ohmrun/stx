package stx.assert.makro.expr.ord;

import stx.makro.expr.HCase as HCaseT;

final Ord = __.assert().Ord();

class HCase extends OrdCls<HCaseT>{
  public function new(){
  }
  public function comply(lhs:HCaseT,rhs:HCaseT){
    var r = Ord.Array(Ord.Makro().Expr().Expr).comply(lhs.values,rhs.values);
    if(r.is_not_less_than()){
      r =  Ord.NullOr(Ord.Makro().Expr().Expr).comply(lhs.guard,rhs.guard);
      if(r.is_not_less_than()){
        r =  Ord.NullOr(Ord.Makro().Expr().Expr).comply(lhs.expr,rhs.expr);
      }
      r;
    }
    return r;
  }
}