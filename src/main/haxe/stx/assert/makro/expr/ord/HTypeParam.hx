package stx.assert.makro.expr.ord;

import stx.makro.expr.HTypeParam as HTypeParamT;

final Ord = __.assert().Ord();

class HTypeParam extends OrdCls<HTypeParamT>{
  public function new(){}
  public function comply(lhs:HTypeParamT,rhs:HTypeParamT){
    return switch([lhs,rhs]){
	    case [TPType(tI),TPType(tII)]   : Ord.Makro().Expr().HComplexType.comply(tI,tII);
	    case [TPExpr(eI),TPExpr(eII)]   : Ord.Makro().Expr().Expr.comply(eI,eII);
      default : Ord.EnumValueIndex().comply(lhs,rhs);
    }
  }
}