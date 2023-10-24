package stx.assert.makro.type.ord;

import stx.makro.type.HClassType as THClassType;
import stx.makro.type.HRef as THRef;

final Ord : STX<stx.assert.Ord<Dynamic>> = __.assert().Ord();

class HClassType extends OrdCls<THClassType>{

  public function new(){}

  public function comply(a:THClassType,b:THClassType):Ordered{
    var ord = Ord.Makro().Type().HClassKind.comply(a.kind,b.kind);
    if(ord.is_not_less_than()){
      ord = Ord.Bool().comply(a.isInterface,b.isInterface);
    }

    if(ord.is_not_less_than()){
      ord = Ord.NullOr(Ord.Anon(op)).comply(a.superClass,b.superClass);
    }
    if(ord.is_not_less_than()){
      ord = Ord.Array(Ord.Anon(op)).comply(a.interfaces,b.interfaces);
    }
    if(ord.is_not_less_than()){
      final x = Ord.Array(Ord.Makro().Type().HClassField);
      final y = Ord.Makro().Type().HRef(x);
      ord = y.comply(a.fields,b.fields);
    }
    if(ord.is_not_less_than()){
      ord = Ord.Array(Ord.Makro().Type().HClassField).comply(a.statics.get(),b.statics.get());
    }
    if(ord.is_not_less_than()){
      //$type(a.constructor);
      //$type(Ord.NullOr(Ord.Makro().Type().HRef(Ord.Makro().Type().HClassField)));
      //$type(Ord.Makro().Type().HRef);
      //$type(Ord.Makro().Type().HClassField);
      ord = Ord.NullOr(Ord.Makro().Type().HRef(Ord.Makro().Type().HClassField)).comply(a.constructor,b.constructor);
    }
    //TODO init?
    if(ord.is_not_less_than()){
      ord = Ord.Array(Ord.Makro().Type().HClassField).comply(a.overrides.map(x -> x.get()),b.overrides.map(x -> x.get()));
    }
    return ord;
  }
  private function op(a:{t:THRef<ClassType>,params:Array<Type>},b:{t:THRef<ClassType>,params:Array<Type>}):Ordered{
    var ord = Ord.Makro().Type().HClassType.comply(a.t.get(),b.t.get());
    if(ord.is_not_less_than()){
      ord = Ord.Array(Ord.Makro().Type().Type).comply(a.params,b.params);
    }
    return ord;
  }
}