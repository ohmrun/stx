package stx.assert.makro.expr.ord;

import stx.makro.expr.HFunctionKind as HFunctionKindT;

final Ord = __.assert().Ord();

class HFunctionKind extends OrdCls<HFunctionKindT>{
  public function new(){}
  public function comply(lhs:HFunctionKindT,rhs:HFunctionKindT){
    return switch([lhs,rhs]){
      case [FAnonymous,FAnonymous] : NotLessThan;
      case [FNamed(nameI, inlinedI),FNamed(nameII, inlinedII)] : 
        var ord = Ord.String().comply(nameI,nameII);
        if(ord.is_ok()){
          ord = Ord.NullOr(Ord.Bool()).comply(inlinedI,inlinedII);
        }
        ord;
      case [FArrow,FArrow] : NotLessThan;
      case [l,r] : Ord.EnumValueIndex().comply(l,r);
    };
  }
}