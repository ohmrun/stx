package stx.assert.makro.type.ord;

import stx.makro.type.HVarAccess as THVarAccess;

final Ord = __.assert().Ord();

class HVarAccess extends OrdCls<THVarAccess>{

  public function new(){}

  public function comply(a:THVarAccess,b:THVarAccess):Ordered{
    return switch([a,b]){
      case [AccRequire(rI, msgI),AccRequire(rII, msgII)]  : 
        var ord = Ord.String().comply(rI,rII);
        if(ord.is_not_less_than()){
          ord = Ord.NullOr(Ord.String()).comply(msgI,msgII);
        }
        ord;
      default                                             : 
        Ord.EnumValueIndex().comply(a,b);
    }
  }
}