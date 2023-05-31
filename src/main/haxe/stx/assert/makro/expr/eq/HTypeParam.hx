package stx.assert.makro.expr.eq;

import stx.makro.expr.HTypeParam as HTypeParamT;

final Eq = __.assert().Eq();

class HTypeParam extends stx.assert.eq.term.Base<HTypeParamT> {
  public function comply(lhs:HTypeParamT,rhs:HTypeParamT){
    return switch([lhs,rhs]){
	    case [TPType(tI),TPType(tII)]     : Eq.Makro().Expr().HComplexType.comply(tI,tII);
	    case [TPExpr(eI),TPExpr(eII)]     : Eq.Makro().Expr().Expr.comply(eI,eII);
      default                           : Eq.EnumValueIndex().comply(lhs,rhs);
    }
  }
}