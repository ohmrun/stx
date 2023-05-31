package stx.assert.makro.type.ord;

import stx.makro.type.HEnumField as THEnumField;

final Ord = __.assert().Ord();

class HEnumField extends OrdCls<THEnumField>{

  public function new(){}

  public function comply(a:THEnumField,b:THEnumField):Ordered{
    var ord = Ord.String().comply(a.name,b.name);
    if(ord.is_not_less_than()){
      ord = Ord.Makro().Type().Type.comply(a.type,b.type);
    }
    if(ord.is_not_less_than()){
      ord = Ord.Makro().Expr().HMetadata.comply(a.meta.get(),b.meta.get());
    }
    //TODO pos?
    if(ord.is_not_less_than()){
      ord = Ord.Int().comply(a.index,b.index);
    }
    if(ord.is_not_less_than()){
      ord = Ord.NullOr(Ord.String()).comply(a.doc,b.doc);
    }
    if(ord.is_not_less_than()){
      ord = Ord.Array(Ord.Makro().Type().HTypeParameter).comply(a.params,b.params);
    }
    return ord;
  }
}