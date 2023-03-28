package stx.assert.g.ord;

import stx.g.lang.expr.GFieldType as GFieldTypeT;

class GFieldType extends OrdCls<GFieldTypeT>{
  public function new(){}
  public function comply(lhs:GFieldTypeT,rhs:GFieldTypeT){
    return switch([lhs,rhs]){
      case [GFVar(tI,eI),GFVar(tII,eII)] : 
        var ord = Ord.NullOr(new GComplexType()).comply(tI,tII);
        if(ord.is_not_less_than()){
          ord = Ord.NullOr(new GExpr()).comply(eI,eII);
        }
        ord;
      case [GFFun(fI),GFFun(fII)] : 
        new GFunction().comply(fI,fII);
      case [GFProp(getI,setI,tI,eI),GFProp(getII,setII,tII,eII)] : 
        var ord = new GPropAccess().comply(getI,getII);
        if(ord.is_not_less_than()){
          ord = new GPropAccess().comply(setI,setII);
        }
        if(ord.is_not_less_than()){
          ord = Ord.NullOr(new GComplexType()).comply(tI,tII);
        }
        if(ord.is_not_less_than()){
          ord = Ord.NullOr(new GExpr()).comply(eI,eII);
        }
        ord;
      default : 
        Ord.EnumValueIndex().comply(lhs,rhs);
    }
  }
}