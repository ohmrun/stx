package stx.assert.makro.type.eq;

import haxe.macro.Type.ClassField as TClassField;

final Eq = __.assert().Eq();

class ClassField extends EqCls<TClassField>{

  public function new(){}

  public function comply(a:TClassField,b:TClassField):Equaled{
    return Eq.Makro().Type().HClassField.comply(a,b);
  }
}