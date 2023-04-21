package stx.assert.g.eq;

import stx.g.lang.expr.GObjectField as GObjectFieldT;

class GObjectField implements EqApi<GObjectFieldT> extends Clazz{
  public function comply(lhs:GObjectFieldT,rhs:GObjectFieldT){
    var eq = Eq.String().comply(lhs.field,rhs.field);
    if(eq.is_ok()){
      eq = new GExpr().comply(lhs.expr,rhs.expr);
    }
    if(eq.is_ok()){
      eq = Eq.NullOr(new GQuoteStatus()).comply(lhs.quotes,rhs.quotes);
    }
    return eq;
  }
} 