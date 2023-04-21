package stx.assert.g.ord;

import stx.g.lang.expr.GConstant as GConstantT;

class GConstant extends OrdCls<GConstantT>{
  public function new(){}
  public function comply(lhs:GConstantT,rhs:GConstantT){
    return switch([lhs,rhs]){
      case [GCInt(vI, sI),GCInt(vII, sII)]      :
        var ord = Ord.String().comply(vI,vII);
        if(ord.is_not_less_than()){
          ord = Ord.NullOr(Ord.String()).comply(sI,sII);
        }
        ord;
      case [GCFloat(fI, sI),GCFloat(fII, sII)]  :
        var ord = Ord.String().comply(fI,fII);
        if(ord.is_not_less_than()){
          ord = Ord.NullOr(Ord.String()).comply(sI,sII);
        }
        ord;
      case [GCString(sI, kindLiteralKindI),GCString(sII, kindLiteralKindII)]:
        var ord = Ord.String().comply(sI,sII);
        if(ord.is_not_less_than()){
          ord = new GStringLiteralKind().comply(kindLiteralKindI,kindLiteralKindII);
        }
        ord;
      case [GCIdent(sI) ,GCIdent(sII) ]:
        Ord.String().comply(sI,sII);
      case [GCRegexp(rI, optI),GCRegexp(rII, optII)]:
        var ord = Ord.String().comply(rI,rII);
        if(ord.is_not_less_than()){
          ord = Ord.String().comply(optI,optII);
        }
        ord;
      default : Ord.EnumValueIndex().comply(lhs,rhs);
    }
  }
}