package stx.assert.makro.expr.eq;

import stx.makro.expr.HFunctionKind as HFunctionKindT;

final Eq = __.assert().Eq();

class HFunctionKind extends stx.assert.eq.term.Base<HFunctionKindT> {
  public function comply(lhs:HFunctionKindT,rhs:HFunctionKindT){
    return switch([lhs,rhs]){
      case [FAnonymous,FAnonymous] : AreEqual;
      case [FNamed(nameI, inlinedI),FNamed(nameII, inlinedII)] : 
        var eq = Eq.String().comply(nameI,nameII);
        if(eq.is_ok()){
          eq = Eq.NullOr(Eq.Bool()).comply(inlinedI,inlinedII);
        }
        eq;
      case [FArrow,FArrow] : AreEqual;
      case [l,r] : Eq.EnumValueIndex().comply(l,r);
    };
  }
}