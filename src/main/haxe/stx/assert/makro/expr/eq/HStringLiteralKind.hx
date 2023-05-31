package stx.assert.makro.expr.eq;

import stx.makro.expr.HStringLiteralKind as THStringLiteralKind;

final Eq = __.assert().Eq();

class HStringLiteralKind extends EqCls<THStringLiteralKind>{

  public function new(){}

  public function comply(a:THStringLiteralKind,b:THStringLiteralKind):Equaled{
    return Eq.EnumValueIndex().comply(a,b);
  }
}