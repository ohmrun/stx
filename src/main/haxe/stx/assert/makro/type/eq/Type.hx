package stx.assert.makro.type.eq;

import haxe.macro.Type as TType;
import stx.makro.type.HType as THType;

final Eq = __.assert().Eq();

class Type extends EqCls<TType>{

  public function new(){}

  public function comply(a:TType,b:TType):Equaled{
    return Eq.Makro().Type().HType.comply(THType.lift(a),THType.lift(b));
  }
}