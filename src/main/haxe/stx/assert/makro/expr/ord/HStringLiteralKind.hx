package stx.assert.makro.expr.ord;

import stx.makro.expr.HStringLiteralKind as THStringLiteralKind;

final Ord = __.assert().Ord();

class HStringLiteralKind extends OrdCls<THStringLiteralKind>{
  public function new(){}
  public function comply(lhs:THStringLiteralKind,rhs:THStringLiteralKind){
    return Ord.EnumValueIndex().comply(lhs,rhs);
  }
}