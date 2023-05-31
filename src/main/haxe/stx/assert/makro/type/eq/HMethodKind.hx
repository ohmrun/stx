package stx.assert.makro.type.eq;

import stx.makro.type.HMethodKind as THMethodKind;

final Eq = __.assert().Eq();

class HMethodKind extends EqCls<THMethodKind>{

  public function new(){}

  public function comply(a:THMethodKind,b:THMethodKind):Equaled{
    return Eq.EnumValueIndex().comply(a,b);
  }
}