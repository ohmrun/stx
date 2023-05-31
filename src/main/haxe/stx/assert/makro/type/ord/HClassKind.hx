package stx.assert.makro.type.ord;

import stx.makro.type.HClassKind as THClassKind;

final Ord = __.assert().Ord();

class HClassKind extends OrdCls<THClassKind>{

  public function new(){}

  public function comply(a:THClassKind,b:THClassKind):Ordered{
    return switch([a,b]){
      case [KNormal,KNormal] : NotLessThan;
      case [KTypeParameter(constraintsI),KTypeParameter(constraintsII)] : 
        //Array<Type>
        Ord.Array(Ord.Makro().Type().Type).comply(constraintsI,constraintsII);
      case [KModuleFields(moduleI),KModuleFields(moduleII)] : 
        //String
        Ord.String().comply(moduleI,moduleII);
      case [KExpr(exprI),KExpr(exprII)] : 
        Ord.Makro().Expr().Expr.comply(exprI,exprII);
      case [KGeneric,KGeneric] : NotLessThan;
      case [KGenericInstance(clI, paramsI),KGenericInstance(clII, paramsII)] : 
        //Ref<ClassType>
        //Array<Type>
        var ord = Ord.Makro().Type().HClassType.comply(clI.get(),clII.get());
        if(ord.is_not_less_than()){
          ord = Ord.Array(Ord.Makro().Type().Type).comply(paramsI,paramsII);
        }
        ord;
      case [KMacroType,KMacroType]      : NotLessThan;
      case [KAbstractImpl(aI),KAbstractImpl(aII)] :
      //Ref<AbstractType>
        Ord.Makro().Type().HAbstractType.comply(aI.get(),aII.get());
      case [KGenericBuild,KGenericBuild] : 
        NotLessThan;
      default : Ord.EnumValueIndex().comply(a,b);
    }
  }
}