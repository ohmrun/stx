package stx.assert.glot.eq;

import eu.ohmrun.glot.expr.GCase as GCaseT;

class GCase extends stx.assert.eq.term.Base<GCaseT> {
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