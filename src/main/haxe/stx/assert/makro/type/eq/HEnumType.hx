package stx.assert.makro.type.eq;

import stx.makro.type.HEnumType as THEnumType;

final Eq = __.assert().Eq();

class HEnumType extends EqCls<THEnumType>{

  public function new(){}

  public function comply(a:THEnumType,b:THEnumType):Equaled{
    var eq : Equaled = Eq.Map(Eq.Makro().Type().HEnumField).comply(a.constructs,b.constructs);
    if(eq.is_ok()){
      eq = Eq.Array(Eq.String()).comply(a.names,b.names);
    }
    return Eq.Makro().Type().HBaseType.comply(a.toBaseType(),b.toBaseType());
  }
}