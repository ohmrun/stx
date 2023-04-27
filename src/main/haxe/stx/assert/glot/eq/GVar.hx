package stx.assert.glot.eq;

import eu.ohmrun.glot.expr.GVar as GVarT;

class GVar extends stx.assert.eq.term.Base<GVarT> {
  public function comply(lhs:GVarT,rhs:GVarT){
    var eq = Eq.String().comply(lhs.name,rhs.name);
    if(eq.is_ok()){
      eq = Eq.NullOr(new GComplexType()).comply(lhs.type,rhs.type);
    }
    if(eq.is_ok()){
      eq = Eq.NullOr(new GExpr()).comply(lhs.expr,rhs.expr);
    }
    if(eq.is_ok()){
      eq = Eq.NullOr(new GMetadata()).comply(lhs.meta,rhs.meta);
    }
    if(eq.is_ok()){
      eq = Eq.NullOr(Eq.Bool()).comply(lhs.isFinal,rhs.isFinal);
    }
    if(eq.is_ok()){
      eq = Eq.NullOr(Eq.Bool()).comply(lhs.isStatic,rhs.isStatic);
    }
    return eq;
  }
}