package stx.assert.makro.expr.ord;

import stx.makro.expr.HComplexType as HComplexTypeT;
import haxe.macro.Expr.ComplexType in TComplexType;

final Ord = __.assert().Ord();

class HComplexType extends OrdCls<HComplexTypeT>{
  public function new(){}
  public function comply(lhs:HComplexTypeT,rhs:HComplexTypeT){
    return switch([lhs,rhs]){
      case [TComplexType.TPath(pI),TComplexType.TPath(pII)]                           : 
        new stx.assert.makro.expr.ord.HTypePath().comply(pI,pII);
      case [TComplexType.TFunction(argsI,retI),TComplexType.TFunction(argsII,retII)]  : 
        var ord = Ord.Array(this).comply(argsI,argsII);
        if(ord.is_not_less_than()){
          ord = comply(retI,retII);
        }
        ord;
      case [TComplexType.TAnonymous(fieldsI),TComplexType.TAnonymous(fieldsII)]       : 
        Ord.Array(Ord.Makro().Expr().HField).comply(fieldsI,fieldsII);
      case [TComplexType.TParent(tI),TComplexType.TParent(tII)]                       : 
        comply(tI,tII);
      case [TComplexType.TExtend(pI,fieldsI) ,TComplexType.TExtend(pII,fieldsII)]     : 
        var lset = RedBlackSet.make(Comparable.Anon(new stx.assert.makro.expr.eq.HTypePath(),Ord.Makro().Expr().HTypePath));
            lset = lset.concat(pI);
        var rset = RedBlackSet.make(Comparable.Anon(new stx.assert.makro.expr.eq.HTypePath(),Ord.Makro().Expr().HTypePath));
            rset = rset.concat(pII);
        var ord  = lset.less_than(rset);
        if(ord.is_not_less_than()){
          var lset = RedBlackSet.make(Comparable.Anon(new stx.assert.makro.expr.eq.HField(),Ord.Makro().Expr().HField));
            lset = lset.concat(fieldsI);
          var rset = RedBlackSet.make(Comparable.Anon(new stx.assert.makro.expr.eq.HField(),Ord.Makro().Expr().HField));
            rset = rset.concat(fieldsII);
          ord = lset.less_than(rset);
        }
        ord;
      case [TComplexType.TOptional(tI),TComplexType.TOptional(tII)]                   : 
        comply(tI,tII);
      case [TComplexType.TNamed(nI,tI),TComplexType.TNamed(nII,tII)]                  : 
        var ord = Ord.String().comply(nI,nII);
        if(ord.is_not_less_than()){
          ord = comply(tI,tII);
        }
        ord;
      case [TComplexType.TIntersection(tlI),TComplexType.TIntersection(tlII)]         : 
        var lset = RedBlackSet.make(Comparable.Anon(new stx.assert.makro.expr.eq.HComplexType(),Ord.Makro().Expr().HComplexType));
            lset = lset.concat(tlI);
        var rset = RedBlackSet.make(Comparable.Anon(new stx.assert.makro.expr.eq.HComplexType(),Ord.Makro().Expr().HComplexType));
            rset = rset.concat(tlII);
        lset.less_than(rset);
      case [l,r]                                              : 
        Ord.EnumValueIndex().comply(l,r);
    }
  }
}