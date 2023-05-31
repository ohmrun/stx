package stx.assert.makro.type.ord;

import haxe.macro.Type.AnonStatus as TAnonStatus;

final Ord = __.assert().Ord();

class AnonStatus extends OrdCls<TAnonStatus>{

  public function new(){}

  public function comply(a:TAnonStatus,b:TAnonStatus):Ordered{
    return Ord.EnumValueIndex().comply(a,b);
  }
}