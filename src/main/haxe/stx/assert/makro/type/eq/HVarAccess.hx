package stx.assert.makro.type.eq;

import stx.makro.type.HVarAccess as THVarAccess;

final Eq = __.assert().Eq();

class HVarAccess extends EqCls<THVarAccess>{

  public function new(){}

  public function comply(a:THVarAccess,b:THVarAccess):Equaled{
    return switch([a,b]){
      case [AccRequire(rI, msgI),AccRequire(rII, msgII)]  : 
        var eq = Eq.String().comply(rI,rII);
        if(eq.is_ok()){
          eq = Eq.NullOr(Eq.String()).comply(msgI,msgII);
        }
        eq;
      default                                             : 
        Eq.EnumValueIndex().comply(a,b);
    }
  }
}