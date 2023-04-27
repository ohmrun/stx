package stx.assert.glot.eq;

import eu.ohmrun.glot.expr.GFunctionArg as GFunctionArgT;

class GFunctionArg extends stx.assert.eq.term.Base<GFunctionArgT> {
  public function comply(lhs:GFunctionArgT,rhs:GFunctionArgT){
    var eq = Eq.String().comply(lhs.name,rhs.name);
    if(eq.is_ok()){
      eq = Eq.NullOr(new GComplexType()).comply(lhs.type,rhs.type);
    }
    if(eq.is_ok()){
      eq = Eq.NullOr(Eq.Bool()).comply(lhs.opt,rhs.opt);
    }
    if(eq.is_ok()){
      eq = Eq.NullOr(new GExpr()).comply(lhs.value,rhs.value);
    }
    if(eq.is_ok()){
      eq = Eq.NullOr(new GMetadata()).comply(lhs.meta,rhs.meta);
    }
    return eq;
  }
}