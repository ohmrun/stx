package stx.assert.makro.expr.ord;

import stx.makro.expr.HConstant as THConstant;

final Ord = __.assert().Ord();

class HConstant extends OrdCls<THConstant>{
  public function new(){}
  public function comply(lhs:THConstant,rhs:THConstant){
    return switch([lhs,rhs]){
      case [CInt(vI, sI),CInt(vII, sII)]      :
        var ord = Ord.String().comply(vI,vII);
        if(ord.is_not_less_than()){
          ord = Ord.NullOr(Ord.String()).comply(sI,sII);
        }
        ord;
      case [CFloat(fI, sI),CFloat(fII, sII)]  :
        var ord = Ord.String().comply(fI,fII);
        if(ord.is_not_less_than()){
          ord = Ord.NullOr(Ord.String()).comply(sI,sII);
        }
        ord;
      case [CString(sI, kindLiteralKindI),CString(sII, kindLiteralKindII)]:
        var ord = Ord.String().comply(sI,sII);
        if(ord.is_not_less_than()){
          ord = new stx.assert.makro.expr.ord.StringLiteralKind().comply(kindLiteralKindI,kindLiteralKindII);
        }
        ord;
      case [CIdent(sI) ,CIdent(sII) ]:
        Ord.String().comply(sI,sII);
      case [CRegexp(rI, optI),CRegexp(rII, optII)]:
        var ord = Ord.String().comply(rI,rII);
        if(ord.is_not_less_than()){
          ord = Ord.String().comply(optI,optII);
        }
        ord;
      default : Ord.EnumValueIndex().comply(lhs,rhs);
    }
  }
}