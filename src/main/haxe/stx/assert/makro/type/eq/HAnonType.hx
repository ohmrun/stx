package stx.assert.makro.type.eq;

import stx.makro.type.HAnonType as THAnonType;

final Eq = __.assert().Eq();

class HAnonType extends EqCls<THAnonType>{

  public function new(){}

  public function comply(a:THAnonType,b:THAnonType):Equaled{
    var eq = new stx.assert.eq.term.ArrayEq(Eq.Makro().Type().HClassField).comply(a.fields,b.fields);
    if(eq.is_ok()){
      eq = Eq.Makro().Type().AnonStatus.comply(a.status,b.status);
    }
    return eq;
  }
}