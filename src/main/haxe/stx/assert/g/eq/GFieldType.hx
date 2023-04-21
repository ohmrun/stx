package stx.assert.g.eq;

import stx.g.lang.expr.GFieldType as GFieldTypeT;

class GFieldType implements EqApi<GFieldTypeT> extends Clazz{
  public function comply(lhs:GFieldTypeT,rhs:GFieldTypeT){
    return switch([lhs,rhs]){
      case [GFVar(tI,eI),GFVar(tII,eII)] : 
        var eq = Eq.NullOr(new GComplexType()).comply(tI,tII);
        if(eq.is_ok()){
          eq = Eq.NullOr(new GExpr()).comply(eI,eII);
        }
        eq;
      case [GFFun(fI),GFFun(fII)] : 
        new GFunction().comply(fI,fII);
      case [GFProp(getI,setI,tI,eI),GFProp(getII,setII,tII,eII)] : 
        var eq = new GPropAccess().comply(getI,getII);
        if(eq.is_ok()){
          eq = new GPropAccess().comply(setI,setII);
        }
        if(eq.is_ok()){
          eq = Eq.NullOr(new GComplexType()).comply(tI,tII);
        }
        if(eq.is_ok()){
          eq = Eq.NullOr(new GExpr()).comply(eI,eII);
        }
        eq;
      default : Eq.EnumValueIndex().comply(lhs,rhs);
    }
  }
}