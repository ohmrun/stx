package stx.assert.makro.type.eq;

import stx.makro.type.HEnumField as THEnumField;

final Eq = __.assert().Eq();

class HEnumField extends EqCls<THEnumField>{

  public function new(){}

  public function comply(a:THEnumField,b:THEnumField):Equaled{
    var eq = Eq.String().comply(a.name,b.name);
    if(eq.is_ok()){
      eq = Eq.Makro().Type().Type.comply(a.type,b.type);
    }
    if(eq.is_ok()){
      eq = Eq.Makro().Expr().Metadata.comply(a.meta.get(),b.meta.get());
    }
    //TODO pos?
    if(eq.is_ok()){
      eq = Eq.Int().comply(a.index,b.index);
    }
    if(eq.is_ok()){
      eq = Eq.NullOr(Eq.String()).comply(a.doc,b.doc);
    }
    if(eq.is_ok()){
      eq = Eq.Array(Eq.Makro().Type().HTypeParameter).comply(a.params,b.params);
    }
    return eq;
  }
}