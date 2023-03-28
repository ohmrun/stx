package stx.assert.g.ord;

import stx.g.lang.expr.GObjectField as GObjectFieldT;

class GObjectField extends OrdCls<GObjectFieldT>{
  public function new(){}
  public function comply(lhs:GObjectFieldT,rhs:GObjectFieldT){
    var ord = Ord.String().comply(lhs.field,rhs.field);
    if(ord.is_not_less_than()){
      ord = new GExpr().comply(lhs.expr,rhs.expr);
    }
    if(ord.is_not_less_than()){
      ord = Ord.NullOr(new GQuoteStatus()).comply(lhs.quotes,rhs.quotes);
    }
    return ord;
  }
}