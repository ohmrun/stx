package stx.assert.g.ord;

import stx.g.lang.expr.GCase as GCaseT;

class GCase extends OrdCls<GCaseT>{
  public function new(){}
  public function comply(lhs:GCaseT,rhs:GCaseT){
    var r = Ord.Cluster(new GExpr()).comply(lhs.values,rhs.values);
    if(r.is_not_less_than()){
      r =  Ord.NullOr(new GExpr()).comply(lhs.guard,rhs.guard);
      if(r.is_not_less_than()){
        r =  Ord.NullOr(new GExpr()).comply(lhs.expr,rhs.expr);
      }
      r;
    }
    return r;
  }
}