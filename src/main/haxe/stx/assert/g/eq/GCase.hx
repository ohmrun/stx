package stx.assert.g.eq;

import stx.g.lang.expr.GCase as GCaseT;

class GCase implements EqApi<GCaseT> extends Clazz{
  public function comply(lhs:GCaseT,rhs:GCaseT){
    var eq = Eq.Cluster(new GExpr()).comply(lhs.values,rhs.values);
    return if(eq.is_ok()){
      eq =  Eq.NullOr(new GExpr()).comply(lhs.guard,rhs.guard);
      if(eq.is_ok()){
        eq =  Eq.NullOr(new GExpr()).comply(lhs.expr,rhs.expr);
      }
      eq;
    }else{
      eq;
    }
  }
}