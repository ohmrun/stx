package stx.assert.glot.eq;

import eu.ohmrun.glot.expr.GCatch as GCatchT;

class GCatch extends stx.assert.eq.term.Base<GCatchT> {
  public function comply(lhs:GCatchT,rhs:GCatchT):Equaled{
    var eq = Eq.String().comply(lhs.name,rhs.name);
    return if(eq.is_ok()){
      eq = new GExpr().comply(lhs.expr,rhs.expr);
      if(eq.is_ok()){
        eq = Eq.NullOr(new GComplexType()).comply(lhs.type,rhs.type);
      }
      eq;
    }else{
      eq;
    }
  }
}