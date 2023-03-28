package stx.assert.g.eq;

import stx.g.lang.expr.GCatch as GCatchT;

class GCatch implements EqApi<GCatchT> extends Clazz{
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