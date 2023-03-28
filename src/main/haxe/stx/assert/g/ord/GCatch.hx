package stx.assert.g.ord;

import stx.g.lang.expr.GCatch as GCatchT;

class GCatch extends OrdCls<GCatchT>{
  public function new(){}
  public function comply(lhs:GCatchT,rhs:GCatchT){
    var ord = Ord.String().comply(lhs.name,rhs.name);
    return if(ord.is_not_less_than()){
      ord = new GExpr().comply(lhs.expr,rhs.expr);
      if(ord.is_not_less_than()){
        ord = Ord.NullOr(new GComplexType()).comply(lhs.type,rhs.type);
      }
      ord;
    }else{
      ord;
    }
  }
}