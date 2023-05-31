package stx.assert.makro.type.ord;

import stx.makro.type.HClassField as THClassField;

final Ord = __.assert().Ord();

class HClassField extends OrdCls<THClassField>{

  public function new(){}

  public function comply(a:THClassField,b:THClassField):Ordered{
    var ord =  Ord.String().comply(a.name,b.name);
    if(ord.is_not_less_than()){
      ord = Ord.Makro().Type().Type.comply(a.type,b.type);
    }
    if(ord.is_not_less_than()){
      ord = Ord.Bool().comply(a.isPublic,b.isPublic);
    }
    if(ord.is_not_less_than()){
      ord = Ord.Bool().comply(a.isExtern,b.isExtern);
    }
    if(ord.is_not_less_than()){
      ord = Ord.Bool().comply(a.isFinal,b.isFinal);
    }
    if(ord.is_not_less_than()){
      ord = Ord.Bool().comply(a.isAbstract,b.isAbstract);
    }
    if(ord.is_not_less_than()){
      ord = Ord.Array(Ord.Makro().Type().HTypeParameter).comply(a.params,b.params);
    }
    if(ord.is_not_less_than()){
      ord = Ord.Makro().Expr().HMetadata.comply(a.meta.get(),b.meta.get());
    }
    if(ord.is_not_less_than()){
      ord = Ord.Makro().Type().HFieldKind.comply(a.kind,b.kind);
    }
    if(ord.is_not_less_than()){
      ord = Ord.NullOr(Ord.String()).comply(a.doc,b.doc);
    }
    //TODO pos?
    if(ord.is_not_less_than()){
      ord = Ord.Array(Ord.Makro().Type().HClassField).comply(a.overloads.get(),b.overloads.get());
    }
    return ord;
  }
}