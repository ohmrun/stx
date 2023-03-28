package stx.assert.g.ord;

import stx.g.lang.expr.GComplexType as GComplexTypeT;

class GComplexType extends OrdCls<GComplexTypeT>{
  public function new(){}
  public function comply(lhs:GComplexTypeT,rhs:GComplexTypeT){
    return switch([lhs,rhs]){
      case [GTPath(pI),GTPath(pII)]                           : 
        new GTypePath().comply(pI,pII);
      case [GTFunction(argsI,retI),GTFunction(argsII,retII)]  : 
        var ord = Ord.Cluster(this).comply(argsI,argsII);
        if(ord.is_not_less_than()){
          ord = comply(retI,retII);
        }
        ord;
      case [GTAnonymous(fieldsI),GTAnonymous(fieldsII)]       : 
        Ord.Cluster(new GField()).comply(fieldsI,fieldsII);
      case [GTParent(tI),GTParent(tII)]                       : 
        comply(tI,tII);
      case [GTExtend(pI,fieldsI) ,GTExtend(pII,fieldsII)]     : 
        var lset = RedBlackSet.make(Comparable.Anon(new stx.assert.g.eq.GTypePath(),new GTypePath()));
            lset = lset.concat(pI);
        var rset = RedBlackSet.make(Comparable.Anon(new stx.assert.g.eq.GTypePath(),new GTypePath()));
            rset = rset.concat(pII);
        var ord  = lset.less_than(rset);
        if(ord.is_not_less_than()){
          var lset = RedBlackSet.make(Comparable.Anon(new stx.assert.g.eq.GField(),new GField()));
            lset = lset.concat(fieldsI);
          var rset = RedBlackSet.make(Comparable.Anon(new stx.assert.g.eq.GField(),new GField()));
            rset = rset.concat(fieldsII);
          ord = lset.less_than(rset);
        }
        ord;
      case [GTOptional(tI),GTOptional(tII)]                   : 
        comply(tI,tII);
      case [GTNamed(nI,tI),GTNamed(nII,tII)]                  : 
        var ord = Ord.String().comply(nI,nII);
        if(ord.is_not_less_than()){
          ord = comply(tI,tII);
        }
        ord;
      case [GTIntersection(tlI),GTIntersection(tlII)]         : 
        var lset = RedBlackSet.make(Comparable.Anon(new stx.assert.g.eq.GComplexType(),new GComplexType()));
            lset = lset.concat(tlI);
        var rset = RedBlackSet.make(Comparable.Anon(new stx.assert.g.eq.GComplexType(),new GComplexType()));
            rset = rset.concat(tlII);
        lset.less_than(rset);
      case [l,r]                                              : 
        Ord.EnumValueIndex().comply(l,r);
    }
  }
}