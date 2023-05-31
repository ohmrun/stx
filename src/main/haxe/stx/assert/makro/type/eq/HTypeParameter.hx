package stx.assert.makro.type.eq;

import stx.makro.type.HTypeParameter as THTypeParameter;

final Eq = __.assert().Eq();

class HTypeParameter extends EqCls<THTypeParameter>{

  public function new(){}

  public function comply(a:THTypeParameter,b:THTypeParameter):Equaled{
    var eq = Eq.String().comply(a.name,b.name);
    if(eq.is_ok()){
      eq = Eq.Makro().Type().Type.comply(a.t,b.t);
    }
    if(eq.is_ok()){
      eq = Eq.NullOr(Eq.Makro().Type().Type).comply(a.defaultType,b.defaultType);
    }
    return eq;
  }
}