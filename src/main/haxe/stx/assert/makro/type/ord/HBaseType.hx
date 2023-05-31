package stx.assert.makro.type.ord;

import stx.makro.type.HBaseType as THBaseType;

final Ord = __.assert().Ord();

class HBaseType extends OrdCls<THBaseType>{

  public function new(){}

  public function comply(a:THBaseType,b:THBaseType):Ordered{
    var ord = Ord.Array(Ord.String()).comply(a.pack,b.pack);
    if(ord.is_not_less_than()){
      ord = Ord.String().comply(a.name,b.name);
    }
    if(ord.is_not_less_than()){
      ord = Ord.String().comply(a.module,b.module);
    }
    if(ord.is_not_less_than()){
      ord = Ord.Bool().comply(a.isPrivate,b.isPrivate);
    }
    if(ord.is_not_less_than()){
      ord = Ord.Bool().comply(a.isExtern,b.isExtern);
    }
    if(ord.is_not_less_than()){
      ord = Ord.Array(Ord.Makro().Type().HTypeParameter).comply(a.params,b.params);
    }
    if(ord.is_not_less_than()){
      ord = Ord.Makro().Expr().HMetadata.comply(a.meta.get(),b.meta.get());
    }
    if(ord.is_not_less_than()){
      ord = Ord.NullOr(Ord.String()).comply(a.doc,b.doc);
    }
    return ord;
  }
}