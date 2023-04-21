package stx.assert.g.ord;

import stx.g.lang.expr.GVar as GVarT;

class GVar extends OrdCls<GVarT>{
  public function new(){}
  public function comply(lhs:GVarT,rhs:GVarT){
    var ord = Ord.String().comply(lhs.name,rhs.name);
    if(ord.is_not_less_than()){
      ord = Ord.NullOr(new GComplexType()).comply(lhs.type,rhs.type);
    }
    if(ord.is_not_less_than()){
      ord = Ord.NullOr(new GExpr()).comply(lhs.expr,rhs.expr);
    }
    if(ord.is_not_less_than()){
      ord = Ord.NullOr(new GMetadata()).comply(lhs.meta,rhs.meta);
    }
    if(ord.is_not_less_than()){
      ord = Ord.NullOr(Ord.Bool()).comply(lhs.isFinal,rhs.isFinal);
    }
    if(ord.is_not_less_than()){
      ord = Ord.NullOr(Ord.Bool()).comply(lhs.isStatic,rhs.isStatic);
    }
    return ord;
  }
}