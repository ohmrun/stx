package stx.assert.g.eq;

import stx.g.lang.expr.GFunctionKind as GFunctionKindT;

class GFunctionKind implements EqApi<GFunctionKindT> extends Clazz{
  public function comply(lhs:GFunctionKindT,rhs:GFunctionKindT){
    return switch([lhs,rhs]){
      case [GFAnonymous,GFAnonymous] : AreEqual;
      case [GFNamed(nameI, inlinedI),GFNamed(nameII, inlinedII)] : 
        var eq = Eq.String().comply(nameI,nameII);
        if(eq.is_ok()){
          eq = Eq.NullOr(Eq.Bool()).comply(inlinedI,inlinedII);
        }
        eq;
      case [GFArrow,GFArrow] : AreEqual;
      case [l,r] : Eq.EnumValueIndex().comply(l,r);
    };
  }
}