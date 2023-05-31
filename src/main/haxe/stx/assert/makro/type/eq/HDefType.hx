package stx.assert.makro.type.eq;

import stx.makro.type.HDefType as THDefType;

final Eq = __.assert().Eq();

class HDefType extends EqCls<THDefType>{

  public function new(){}

  public function comply(a:THDefType,b:THDefType):Equaled{
    final eq = Eq.Makro().Type().Type.comply(a.type,b.type);
    return Eq.Makro().Type().HBaseType.comply(a.toBaseType(),b.toBaseType());
  }
}