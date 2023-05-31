package stx.assert.makro.type.ord;

import stx.makro.type.HMethodKind as THMethodKind;

final Ord = __.assert().Ord();

class HMethodKind extends OrdCls<THMethodKind>{

  public function new(){}

  public function comply(a:THMethodKind,b:THMethodKind):Ordered{
    return Ord.EnumValueIndex().comply(a,b);
  }
}