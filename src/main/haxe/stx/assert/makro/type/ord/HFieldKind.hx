package stx.assert.makro.type.ord;

import stx.makro.type.HFieldKind as THFieldKind;

final Ord = __.assert().Ord();

class HFieldKind extends OrdCls<THFieldKind>{

  public function new(){}

  public function comply(a:THFieldKind,b:THFieldKind):Ordered{
    return switch([a,b]){
      case [FVar(readI,writeI),FVar(readII,writeII)] : 
        var ord = Ord.Makro().Type().HVarAccess.comply(readI,readII);
        if(ord.is_not_less_than()){
          ord = Ord.Makro().Type().HVarAccess.comply(writeI,writeII);
        }
        ord;
      case [FMethod(kI),FMethod(kII)] : 
        Ord.Makro().Type().HMethodKind.comply(kI,kII);
      default : 
        Ord.EnumValueIndex().comply(a,b);  
    }
  }
}
