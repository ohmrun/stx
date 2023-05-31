package stx.assert.makro.type.eq;

import haxe.macro.Type.AnonStatus as TAnonStatus;

final Eq = __.assert().Eq();

class AnonStatus extends EqCls<TAnonStatus>{

  public function new(){}

  public function comply(a:TAnonStatus,b:TAnonStatus):Equaled{
    return Eq.EnumValueIndex().comply(a,b);
  }
}