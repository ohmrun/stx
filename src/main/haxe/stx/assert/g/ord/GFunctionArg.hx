package stx.assert.g.ord;

import stx.g.lang.expr.GFunctionArg as GFunctionArgT;

class GFunctionArg extends OrdCls<GFunctionArgT>{
  public function new(){}
  public function comply(lhs:GFunctionArgT,rhs:GFunctionArgT){
    var ord = Ord.String().comply(lhs.name,rhs.name);
    if(ord.is_not_less_than()){
      ord = Ord.NullOr(new GComplexType()).comply(lhs.type,rhs.type);
    }
    if(ord.is_not_less_than()){
      ord = Ord.NullOr(Ord.Bool()).comply(lhs.opt,rhs.opt);
    }
    if(ord.is_not_less_than()){
      ord = Ord.NullOr(new GExpr()).comply(lhs.value,rhs.value);
    }
    if(ord.is_not_less_than()){
      ord = Ord.NullOr(new GMetadata()).comply(lhs.meta,rhs.meta);
    }
    return ord;
  }
}