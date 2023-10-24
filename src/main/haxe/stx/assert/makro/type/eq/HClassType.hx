package stx.assert.makro.type.eq;

import stx.makro.type.HClassType as THClassType;
import stx.makro.type.HRef as THRef;

final Eq : STX<stx.assert.Eq<Dynamic>> = __.assert().Eq();

class HClassType extends EqCls<THClassType>{

  public function new(){}

  public function comply(a:THClassType,b:THClassType):Equaled{
    var eq = Eq.Makro().Type().HClassKind.comply(a.kind,b.kind);
    if(eq.is_ok()){
      eq = Eq.Bool().comply(a.isInterface,b.isInterface);
    }
    if(eq.is_ok()){
      eq = Eq.NullOr(Eq.Anon(op)).comply(a.superClass,b.superClass);
    }
    if(eq.is_ok()){
      eq = Eq.Array(Eq.Anon(op)).comply(a.interfaces,b.interfaces);
    }
    if(eq.is_ok()){
      final x = Eq.Array(Eq.Makro().Type().HClassField);
      final y = Eq.Makro().Type().HRef(x);
      eq = y.comply(a.fields,b.fields);
    }
    if(eq.is_ok()){
      eq = Eq.Array(Eq.Makro().Type().HClassField).comply(a.statics.get(),b.statics.get());
    }
    if(eq.is_ok()){
      //$type(a.constructor);
      //$type(Eq.NullOr(Eq.Makro().Type().HRef(Eq.Makro().Type().HClassField)));
      //$type(Eq.Makro().Type().HRef);
      //$type(Eq.Makro().Type().HClassField);
      eq = Eq.NullOr(Eq.Makro().Type().HRef(Eq.Makro().Type().HClassField)).comply(a.constructor,b.constructor);
    }
    //TODO init?
    if(eq.is_ok()){
      eq = Eq.Array(Eq.Makro().Type().HClassField).comply(a.overrides.map(x -> x.get()),b.overrides.map(x -> x.get()));
    }
    return eq;
  }
  private function op(a:{t:THRef<ClassType>,params:Array<Type>},b:{t:THRef<ClassType>,params:Array<Type>}):Equaled{
    var eq = Eq.Makro().Type().HClassType.comply(a.t.get(),b.t.get());
    if(eq.is_ok()){
      eq = Eq.Array(Eq.Makro().Type().Type).comply(a.params,b.params);
    }
    return eq;
  }
}