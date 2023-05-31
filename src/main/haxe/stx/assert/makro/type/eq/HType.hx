package stx.assert.makro.type.eq;

import stx.makro.type.HType as THType;

final Eq = __.assert().Eq();

class HType extends EqCls<THType>{

  public function new(){}

  public function comply(a:THType,b:THType):Equaled{
    return switch([a,b]){
      case [TMono(tI)              ,TMono(tII)                ]: 
        ref(Eq.NullOr(Eq.Makro().Type().Type)).comply(tI,tII);
      case [TEnum(tI,paramsI)      ,TEnum(tII,paramsII)       ]:
        var eq = ref(Eq.Makro().Type().HEnumType).comply(tI,tII);
        if(eq.is_ok()){
          params_op().comply(paramsI,paramsII);
        }
        eq;
      case [TInst(tI,paramsI)      ,TInst(tII,paramsII)       ]:
        var eq = ref(Eq.Makro().Type().HClassType).comply(tI,tII);
        if(eq.is_ok()){
          params_op().comply(paramsI,paramsII);
        }
        eq;
      case [TType(tI,paramsI)      ,TType(tII,paramsII)       ]:
        var eq = ref(Eq.Makro().Type().HDefType).comply(tI,tII);
        if(eq.is_ok()){
          params_op().comply(paramsI,paramsII);
        }
        eq;
      case [TFun(argsI, retI)      ,TFun(argsII, retII)       ]:
        var eq = Eq.Array(Eq.Anon(args_op)).comply(argsI,argsII);
        if(eq.is_ok()){
          eq = Eq.Makro().Type().Type.comply(retI,retII);
        }
        eq;
      case [TAnonymous(aI)         ,TAnonymous(aII)           ]:
        ref(Eq.Makro().Type().HAnonType).comply(aI,aII);
      case [TDynamic(tI)           ,TDynamic(tII)             ]:
        Eq.NullOr(Eq.Makro().Type().Type).comply(tI,tII);
      case [TLazy(fI)              ,TLazy(fII)                ]:
        Eq.NullOr(Eq.Makro().Type().Type).comply(fI(),fII());
      case [TAbstract(tI, paramsI) ,TAbstract(tII,paramsII)  ] :
        var eq = ref(Eq.Makro().Type().HAbstractType).comply(tI,tII);
        if(eq.is_ok()){
          eq = params_op().comply(paramsI,paramsII);
        }
        return eq;
      default : Eq.EnumValueIndex().comply(a,b);
    }
  }
  private function params_op(){
    return Eq.Array(Eq.Makro().Type().Type);
  }
  private function args_op(a:{name : String,opt: Bool, t:Type},b:{name : String,opt: Bool, t:Type}){
    var eq = Eq.String().comply(a.name,b.name);
    if(eq.is_ok()){
      eq = Eq.Bool().comply(a.opt,b.opt);
    }
    if(eq.is_ok()){
      eq = Eq.Makro().Type().Type.comply(a.t,b.t);
    }
    return eq;
  }
  private function ref<T>(self:stx.assert.Eq<T>){
    return Eq.Makro().Type().HRef(self);
  }
}
