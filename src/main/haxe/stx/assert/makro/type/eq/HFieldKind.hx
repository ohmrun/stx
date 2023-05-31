package stx.assert.makro.type.eq;

import stx.makro.type.HFieldKind as THFieldKind;

final Eq = __.assert().Eq();

class HFieldKind extends EqCls<THFieldKind>{

  public function new(){}

  public function comply(a:THFieldKind,b:THFieldKind):Equaled{
    return switch([a,b]){
      case [FVar(readI,writeI),FVar(readII,writeII)] : 
        var eq = Eq.Makro().Type().HVarAccess.comply(readI,readII);
        if(eq.is_ok()){
          eq = Eq.Makro().Type().HVarAccess.comply(writeI,writeII);
        }
        eq;
      case [FMethod(kI),FMethod(kII)] : 
        Eq.Makro().Type().HMethodKind.comply(kI,kII);
      default : 
        Eq.EnumValueIndex().comply(a,b);  
    }
  }
}
