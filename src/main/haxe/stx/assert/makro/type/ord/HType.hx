package stx.assert.makro.type.ord;

import stx.makro.type.HType as THType;

final Ord = __.assert().Ord();

class HType extends OrdCls<THType>{

  public function new(){}

  public function comply(a:THType,b:THType):Ordered{
    return switch([a,b]){
      case [TMono(tI)              ,TMono(tII)                ]: 
        ref(Ord.NullOr(Ord.Makro().Type().Type)).comply(tI,tII);
      case [TEnum(tI,paramsI)      ,TEnum(tII,paramsII)       ]:
        var ord = ref(Ord.Makro().Type().HEnumType).comply(tI,tII);
        if(ord.is_not_less_than()){
          params_op().comply(paramsI,paramsII);
        }
        ord;
      case [TInst(tI,paramsI)      ,TInst(tII,paramsII)       ]:
        var ord = ref(Ord.Makro().Type().HClassType).comply(tI,tII);
        if(ord.is_not_less_than()){
          params_op().comply(paramsI,paramsII);
        }
        ord;
      case [TType(tI,paramsI)      ,TType(tII,paramsII)       ]:
        var ord = ref(Ord.Makro().Type().HDefType).comply(tI,tII);
        if(ord.is_not_less_than()){
          params_op().comply(paramsI,paramsII);
        }
        ord;
      case [TFun(argsI, retI)      ,TFun(argsII, retII)       ]:
        var ord = Ord.Array(Ord.Anon(args_op)).comply(argsI,argsII);
        if(ord.is_not_less_than()){
          ord = Ord.Makro().Type().Type.comply(retI,retII);
        }
        ord;
      case [TAnonymous(aI)         ,TAnonymous(aII)           ]:
        ref(Ord.Makro().Type().HAnonType).comply(aI,aII);
      case [TDynamic(tI)           ,TDynamic(tII)             ]:
        Ord.NullOr(Ord.Makro().Type().Type).comply(tI,tII);
      case [TLazy(fI)              ,TLazy(fII)                ]:
        Ord.NullOr(Ord.Makro().Type().Type).comply(fI(),fII());
      case [TAbstract(tI, paramsI) ,TAbstract(tII,paramsII)  ] :
        var ord = ref(Ord.Makro().Type().HAbstractType).comply(tI,tII);
        if(ord.is_not_less_than()){
          ord = params_op().comply(paramsI,paramsII);
        }
        return ord;
      default : Ord.EnumValueIndex().comply(a,b);
    }
  }
  private function params_op(){
    return Ord.Array(Ord.Makro().Type().Type);
  }
  private function args_op(a:{name : String,opt: Bool, t:Type},b:{name : String,opt: Bool, t:Type}){
    var ord = Ord.String().comply(a.name,b.name);
    if(ord.is_not_less_than()){
      ord = Ord.Bool().comply(a.opt,b.opt);
    }
    if(ord.is_not_less_than()){
      ord = Ord.Makro().Type().Type.comply(a.t,b.t);
    }
    return ord;
  }
  private function ref<T>(self:stx.assert.Ord<T>){
    return Ord.Makro().Type().HRef(self);
  }
}
