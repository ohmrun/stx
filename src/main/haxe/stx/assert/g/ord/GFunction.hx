package stx.assert.g.ord;

import stx.g.lang.expr.GFunction as GFunctionT;

class GFunction extends OrdCls<GFunctionT>{
  public function new(){}
  public function comply(lhs:GFunctionT,rhs:GFunctionT){
    var ord = Ord.Cluster(new GFunctionArg()).comply(lhs.args,rhs.args);
    if(ord.is_not_less_than()){
      ord = Ord.NullOr(new GComplexType()).comply(lhs.ret,rhs.ret);
    }
    if(ord.is_not_less_than()){
      ord = Ord.NullOr(new GExpr()).comply(lhs.expr,rhs.expr);
    }
    if(ord.is_not_less_than()){
      ord = Ord.NullOr(Ord.Cluster(new GTypeParamDecl())).comply(lhs.params,rhs.params);
    }
    return ord;
  }
}