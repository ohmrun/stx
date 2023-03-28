package stx.assert.g.eq;

import stx.g.lang.expr.GComplexType as GComplexTypeT;

class GComplexType implements EqApi<GComplexTypeT> extends Clazz{
  public function comply(lhs:GComplexTypeT,rhs:GComplexTypeT){
    return switch([lhs,rhs]){
      case [GTPath(pI),GTPath(pII)]                           : 
        new GTypePath().comply(pI,pII);
      case [GTFunction(argsI,retI),GTFunction(argsII,retII)]  : 
        var eq = Eq.Cluster(this).comply(argsI,argsII);
        if(eq.is_ok()){
          eq = comply(retI,retII);
        }
        eq;
      case [GTAnonymous(fieldsI),GTAnonymous(fieldsII)]       : 
        Eq.Cluster(new GField()).comply(fieldsI,fieldsII);
      case [GTParent(tI),GTParent(tII)]                       : 
        comply(tI,tII);
      case [GTExtend(pI,fieldsI) ,GTExtend(pII,fieldsII)]     : 
        var lset = RedBlackSet.make(Comparable.Anon(new GTypePath(),new stx.assert.g.ord.GTypePath()));
            lset = lset.concat(pI);
        var rset = RedBlackSet.make(Comparable.Anon(new GTypePath(),new stx.assert.g.ord.GTypePath()));
            rset = rset.concat(pII);
        var eq   = lset.equals(rset);
        if(eq.is_ok()){
          var lset = RedBlackSet.make(Comparable.Anon(new GField(),new stx.assert.g.ord.GField()));
            lset = lset.concat(fieldsI);
          var rset = RedBlackSet.make(Comparable.Anon(new GField(),new stx.assert.g.ord.GField()));
            rset = rset.concat(fieldsII);
          eq = lset.equals(rset);
        }
        eq;
      case [GTOptional(tI),GTOptional(tII)]                   : 
        comply(tI,tII);
      case [GTNamed(nI,tI),GTNamed(nII,tII)]                  : 
        var eq = Eq.String().comply(nI,nII);
        if(eq.is_ok()){
          eq = comply(tI,tII);
        }
        eq;
      case [GTIntersection(tlI),GTIntersection(tlII)]         : 
        var lset = RedBlackSet.make(Comparable.Anon(this,new stx.assert.g.ord.GComplexType()));
            lset = lset.concat(tlI);
        var rset = RedBlackSet.make(Comparable.Anon(this,new stx.assert.g.ord.GComplexType()));
            rset = rset.concat(tlII);
        lset.equals(rset);
      case [l,r]                                              : 
        Eq.EnumValueIndex().comply(l,r);
    }
  }
}