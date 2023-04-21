package stx.assert.g.eq;

import stx.g.lang.expr.GFunction as GFunctionT;

class GFunction implements EqApi<GFunctionT> extends Clazz{
  public function comply(lhs:GFunctionT,rhs:GFunctionT){
    var eq = Eq.Cluster(new GFunctionArg()).comply(lhs.args,rhs.args);
    if(eq.is_ok()){
      eq = Eq.NullOr(new GComplexType()).comply(lhs.ret,rhs.ret);
    }
    if(eq.is_ok()){
      eq = Eq.NullOr(new GExpr()).comply(lhs.expr,rhs.expr);
    }
    if(eq.is_ok()){
      eq = Eq.NullOr(Eq.Cluster(new GTypeParamDecl())).comply(lhs.params,rhs.params);
    }
    return eq;
  }
}