package stx.assert.g.ord;

import stx.g.lang.expr.GTypeParam as GTypeParamT;

class GTypeParam extends OrdCls<GTypeParamT>{
  public function new(){}
  public function comply(lhs:GTypeParamT,rhs:GTypeParamT){
    return switch([lhs,rhs]){
	    case [GTPType(tI),GTPType(tII)]   : new GComplexType().comply(tI,tII);
	    case [GTPExpr(eI),GTPExpr(eII)]   : new GExpr().comply(eI,eII);
      default : Ord.EnumValueIndex().comply(lhs,rhs);
    }
  }
}