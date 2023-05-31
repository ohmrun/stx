package stx.assert.makro.type.eq;

import stx.makro.type.HClassKind as THClassKind;

final Eq = __.assert().Eq();

class HClassKind extends EqCls<THClassKind>{

  public function new(){}

  public function comply(a:THClassKind,b:THClassKind):Equaled{
    return switch([a,b]){
      case [KNormal,KNormal] : AreEqual;
      case [KTypeParameter(constraintsI),KTypeParameter(constraintsII)] : 
        //Array<Type>
        Eq.Array(Eq.Makro().Type().Type).comply(constraintsI,constraintsII);
      case [KModuleFields(moduleI),KModuleFields(moduleII)] : 
        //String
        Eq.String().comply(moduleI,moduleII);
      case [KExpr(exprI),KExpr(exprII)] : 
        Eq.Makro().Expr().Expr.comply(exprI,exprII);
      case [KGeneric,KGeneric] : AreEqual;
      case [KGenericInstance(clI, paramsI),KGenericInstance(clII, paramsII)] : 
        //Ref<ClassType>
        //Array<Type>
        var eq = Eq.Makro().Type().HClassType.comply(clI.get(),clII.get());
        if(eq.is_ok()){
          eq = Eq.Array(Eq.Makro().Type().Type).comply(paramsI,paramsII);
        }
        eq;
      case [KMacroType,KMacroType]      : AreEqual;
      case [KAbstractImpl(aI),KAbstractImpl(aII)] :
      //Ref<AbstractType>
        Eq.Makro().Type().HAbstractType.comply(aI.get(),aII.get());
      case [KGenericBuild,KGenericBuild] : 
        AreEqual;
      default : Eq.EnumValueIndex().comply(a,b);
    }
  }
}