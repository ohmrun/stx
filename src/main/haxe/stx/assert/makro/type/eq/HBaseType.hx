package stx.assert.makro.type.eq;

import stx.makro.type.HBaseType as THBaseType;

final Eq = __.assert().Eq();

class HBaseType extends EqCls<THBaseType>{

  public function new(){}

  public function comply(a:THBaseType,b:THBaseType):Equaled{
    var eq = Eq.Array(Eq.String()).comply(a.pack,b.pack);
    if(eq.is_ok()){
      eq = Eq.String().comply(a.name,b.name);
    }
    if(eq.is_ok()){
      eq = Eq.String().comply(a.module,b.module);
    }
    if(eq.is_ok()){
      eq = Eq.Bool().comply(a.isPrivate,b.isPrivate);
    }
    if(eq.is_ok()){
      eq = Eq.Bool().comply(a.isExtern,b.isExtern);
    }
    if(eq.is_ok()){
      eq = Eq.Array(Eq.Makro().Type().HTypeParameter).comply(a.params,b.params);
    }
    if(eq.is_ok()){
      eq = Eq.Makro().Expr().Metadata.comply(a.meta.get(),b.meta.get());
    }
    if(eq.is_ok()){
      eq = Eq.NullOr(Eq.String()).comply(a.doc,b.doc);
    }
    return eq;
  }
}