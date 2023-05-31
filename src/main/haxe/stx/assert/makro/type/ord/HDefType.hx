package stx.assert.makro.type.ord;

import stx.makro.type.HDefType as THDefType;

final Ord = __.assert().Ord();

class HDefType extends OrdCls<THDefType>{

  public function new(){}

  public function comply(a:THDefType,b:THDefType):Ordered{
    final ord = Ord.Makro().Type().Type.comply(a.type,b.type);
    return Ord.Makro().Type().HBaseType.comply(a.toBaseType(),b.toBaseType());
  }
}