package stx.assert.glot.ord;

import eu.ohmrun.glot.expr.GEField as GEFieldT;

class GEField extends OrdCls<GEFieldT>{
  public function new(){}
  public function comply(lhs:GEFieldT,rhs:GEFieldT){
    var ord = Ord.String().comply(lhs.name,rhs.name);
    if(ord.is_not_less_than()){
      ord = new GFieldType().comply(lhs.kind,rhs.kind);
    }
    if(ord.is_not_less_than()){
      final ctr = () -> RedBlackSet.make(Comparable.Anon(new stx.assert.glot.eq.GAccess(),new GAccess()));
      var lset = ctr();
          lset = lset.concat(__.option(lhs.access).defv([].imm()));
      var rset = ctr();
          rset = rset.concat(__.option(rhs.access).defv([].imm()));
      ord = lset.less_than(rset);
    }
    if(ord.is_not_less_than()){
      ord = new GFieldType().comply(lhs.kind,rhs.kind);
    }
    if(ord.is_not_less_than()){
      ord = Ord.NullOr(new GMetadata()).comply(lhs.meta,rhs.meta);
    }
    if(ord.is_not_less_than()){
      ord = Ord.NullOr(Ord.String()).comply(lhs.doc,rhs.doc);
    }
    return ord;
  }
}