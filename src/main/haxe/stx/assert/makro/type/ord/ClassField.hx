package stx.assert.makro.type.ord;

import haxe.macro.Type.ClassField as TClassField;

final Ord = __.assert().Ord();

class ClassField extends OrdCls<TClassField>{

  public function new(){}

  public function comply(a:TClassField,b:TClassField):Ordered{
    return Ord.Makro().Type().HClassField.comply(a,b);
  }
}