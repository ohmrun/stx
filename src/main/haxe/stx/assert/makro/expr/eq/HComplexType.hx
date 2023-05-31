package stx.assert.makro.expr.eq;

import stx.makro.expr.HComplexType as THComplexType;

final Eq = __.assert().Eq();

class HComplexType extends stx.assert.eq.term.Base<THComplexType> {
  public function comply(lhs:THComplexType,rhs:THComplexType){
    return switch([lhs,rhs]){
      case [TPath(pI),TPath(pII)]                           : 
        Eq.Makro().Expr().HTypePath.comply(pI,pII);
      case [ComplexType.TFunction(argsI,retI),ComplexType.TFunction(argsII,retII)]  : 
        var eq = Eq.Array(this).comply(argsI,argsII);
        if(eq.is_ok()){
          eq = comply(retI,retII);
        }
        eq;
      case [ComplexType.TAnonymous(fieldsI),ComplexType.TAnonymous(fieldsII)]       : 
        Eq.Array(Eq.Makro().Expr().HField).comply(fieldsI,fieldsII);
      case [TParent(tI),TParent(tII)]                       : 
        comply(tI,tII);
      case [TExtend(pI,fieldsI) ,TExtend(pII,fieldsII)]     : 
        var lset = RedBlackSet.make(Comparable.Anon(Eq.Makro().Expr().HTypePath,new stx.assert.makro.expr.ord.HTypePath()));
            lset = lset.concat(pI);
        var rset = RedBlackSet.make(Comparable.Anon(Eq.Makro().Expr().HTypePath,new stx.assert.makro.expr.ord.HTypePath()));
            rset = rset.concat(pII);
        var eq   = lset.equals(rset);
        if(eq.is_ok()){
          var lset = RedBlackSet.make(Comparable.Anon(Eq.Makro().Expr().HField,new stx.assert.makro.expr.ord.HField()));
            lset = lset.concat(fieldsI);
          var rset = RedBlackSet.make(Comparable.Anon(Eq.Makro().Expr().HField,new stx.assert.makro.expr.ord.HField()));
            rset = rset.concat(fieldsII);
          eq = lset.equals(rset);
        }
        eq;
      case [TOptional(tI),TOptional(tII)]                   : 
        comply(tI,tII);
      case [TNamed(nI,tI),TNamed(nII,tII)]                  : 
        var eq = Eq.String().comply(nI,nII);
        if(eq.is_ok()){
          eq = comply(tI,tII);
        }
        eq;
      case [TIntersection(tlI),TIntersection(tlII)]         : 
        var lset = RedBlackSet.make(Comparable.Anon(this,new stx.assert.makro.expr.ord.HComplexType()));
            lset = lset.concat(tlI);
        var rset = RedBlackSet.make(Comparable.Anon(this,new stx.assert.makro.expr.ord.HComplexType()));
            rset = rset.concat(tlII);
        lset.equals(rset);
      case [l,r]                                              : 
        Eq.EnumValueIndex().comply(l,r);
    }
  }
}