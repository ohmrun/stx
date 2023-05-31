package stx.assert.makro.type.ord;

import stx.makro.type.HEnumType as THEnumType;

final Ord = __.assert().Ord();

class HEnumType extends OrdCls<THEnumType>{

  public function new(){}

  public function comply(a:THEnumType,b:THEnumType):Ordered{
    var ord = Ord.Map(Ord.String(),Ord.Makro().Type().HEnumField).comply(a.constructs,b.constructs);
    if(ord.is_not_less_than()){
      ord = Ord.Array(Ord.String()).comply(a.names,b.names);
    }
    return Ord.Makro().Type().HBaseType.comply(a.toBaseType(),b.toBaseType());
  }
}