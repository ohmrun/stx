package stx.assert.makro.type.ord;

import stx.makro.type.HAnonType as THAnonType;

final Ord = __.assert().Ord();

class HAnonType extends OrdCls<THAnonType>{

  public function new(){}

  public function comply(a:THAnonType,b:THAnonType):Ordered{
    var ord = Ord.Array(Ord.Makro().Type().HClassField).comply(a.fields,b.fields);
    if(ord.is_not_less_than()){
      ord = Ord.Makro().Type().AnonStatus.comply(a.status,b.status);
    }
    return ord;
  }
}