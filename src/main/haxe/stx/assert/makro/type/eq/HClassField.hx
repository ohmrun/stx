package stx.assert.makro.type.eq;

import stx.makro.type.HClassField as THClassField;

final Eq = __.assert().Eq();

class HClassField extends EqCls<THClassField>{

  public function new(){}

  public function comply(a:THClassField,b:THClassField):Equaled{
    var eq =  Eq.String().comply(a.name,b.name);
    if(eq.is_ok()){
      eq = Eq.Makro().Type().Type.comply(a.type,b.type);
    }
    if(eq.is_ok()){
      eq = Eq.Bool().comply(a.isPublic,b.isPublic);
    }
    if(eq.is_ok()){
      eq = Eq.Bool().comply(a.isExtern,b.isExtern);
    }
    if(eq.is_ok()){
      eq = Eq.Bool().comply(a.isFinal,b.isFinal);
    }
    if(eq.is_ok()){
      eq = Eq.Bool().comply(a.isAbstract,b.isAbstract);
    }
    if(eq.is_ok()){
      eq = Eq.Array(Eq.Makro().Type().HTypeParameter).comply(a.params,b.params);
    }
    if(eq.is_ok()){
      eq = Eq.Makro().Expr().Metadata.comply(a.meta.get(),b.meta.get());
    }
    if(eq.is_ok()){
      eq = Eq.Makro().Type().HFieldKind.comply(a.kind,b.kind);
    }
    if(eq.is_ok()){
      eq = Eq.NullOr(Eq.String()).comply(a.doc,b.doc);
    }
    //TODO pos?
    if(eq.is_ok()){
      eq = Eq.Array(Eq.Makro().Type().HClassField).comply(a.overloads.get(),b.overloads.get());
    }
    return eq;
  }
}