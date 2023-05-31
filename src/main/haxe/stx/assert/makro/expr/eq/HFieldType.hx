package stx.assert.makro.expr.eq;

import stx.makro.expr.HFieldType as THFieldType;

final Eq = __.assert().Eq();

class HFieldType extends stx.assert.eq.term.Base<THFieldType> {
  public function comply(lhs:THFieldType,rhs:THFieldType){
    return switch([lhs,rhs]){
      case [FVar(tI,eI),FVar(tII,eII)] : 
        var eq = Eq.NullOr(Eq.Makro().Expr().HComplexType).comply(tI,tII);
        if(eq.is_ok()){
          eq = Eq.NullOr(Eq.Makro().Expr().Expr).comply(eI,eII);
        }
        eq;
      case [FFun(fI),FFun(fII)] : 
        Eq.Makro().Expr().HFunction.comply(fI,fII);
      case [FProp(getI,setI,tI,eI),FProp(getII,setII,tII,eII)] : 
        var eq = Eq.Makro().Expr().HPropAccess.comply(getI,getII);
        if(eq.is_ok()){
          eq = Eq.Makro().Expr().HPropAccess.comply(setI,setII);
        }
        if(eq.is_ok()){
          eq = Eq.NullOr(Eq.Makro().Expr().HComplexType).comply(tI,tII);
        }
        if(eq.is_ok()){
          eq = Eq.NullOr(Eq.Makro().Expr().Expr).comply(eI,eII);
        }
        eq;
      default : Eq.EnumValueIndex().comply(lhs,rhs);
    }
  }
}