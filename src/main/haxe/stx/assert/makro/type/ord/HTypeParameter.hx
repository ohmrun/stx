package stx.assert.makro.type.ord;

import stx.makro.type.HTypeParameter as THTypeParameter;

final Ord = __.assert().Ord();

class HTypeParameter extends OrdCls<THTypeParameter>{

  public function new(){}

  public function comply(a:THTypeParameter,b:THTypeParameter):Ordered{
    var ord = Ord.String().comply(a.name,b.name);
    if(ord.is_not_less_than()){
      ord = Ord.Makro().Type().Type.comply(a.t,b.t);
    }
    if(ord.is_not_less_than()){
      ord = Ord.NullOr(Ord.Makro().Type().Type).comply(a.defaultType,b.defaultType);
    }
    return ord;
  }
}