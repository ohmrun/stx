package stx.assert.g.ord;

import stx.g.lang.expr.GFunctionKind as GFunctionKindT;

class GFunctionKind extends OrdCls<GFunctionKindT>{
  public function new(){}
  public function comply(lhs:GFunctionKindT,rhs:GFunctionKindT){
    return switch([lhs,rhs]){
      case [GFAnonymous,GFAnonymous] : NotLessThan;
      case [GFNamed(nameI, inlinedI),GFNamed(nameII, inlinedII)] : 
        var ord = Ord.String().comply(nameI,nameII);
        if(ord.is_ok()){
          ord = Ord.NullOr(Ord.Bool()).comply(inlinedI,inlinedII);
        }
        ord;
      case [GFArrow,GFArrow] : NotLessThan;
      case [l,r] : Ord.EnumValueIndex().comply(l,r);
    };
  }
}