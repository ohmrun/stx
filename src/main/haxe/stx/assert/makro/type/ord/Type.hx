package stx.assert.makro.type.ord;

import haxe.macro.Type as TType;
import stx.makro.type.HType as THType;

final Ord = __.assert().Ord();

class Type extends OrdCls<TType>{

  public function new(){}

  public function comply(a:TType,b:TType):Ordered{
    return Ord.Makro().Type().HType.comply(THType.lift(a),THType.lift(b));
  }
}