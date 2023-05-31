package stx.assert.makro.expr.ord;

import stx.makro.expr.HField as HFieldT;

final Ord = __.assert().Ord();

class HField extends OrdCls<HFieldT>{
  public function new(){}
  public function comply(lhs:HFieldT,rhs:HFieldT){
    var ord = Ord.String().comply(lhs.name,rhs.name);
    if(ord.is_not_less_than()){
      ord = Ord.Makro().Expr().HFieldType.comply(lhs.kind,rhs.kind);
    }
    if(ord.is_not_less_than()){
      final ctr = () -> RedBlackSet.make(Comparable.Anon(new stx.assert.makro.expr.eq.HAccess(),Ord.Makro().Expr().HAccess));
      var lset = ctr();
          lset = lset.concat(__.option(lhs.access).defv([]));
      var rset = ctr();
          rset = rset.concat(__.option(rhs.access).defv([]));
      ord = lset.less_than(rset);
    }
    if(ord.is_not_less_than()){
      ord = Ord.Makro().Expr().HFieldType.comply(lhs.kind,rhs.kind);
    }
    if(ord.is_not_less_than()){
      ord = Ord.NullOr(Ord.Makro().Expr().HMetadata).comply(lhs.meta,rhs.meta);
    }
    if(ord.is_not_less_than()){
      ord = Ord.NullOr(Ord.String()).comply(lhs.doc,rhs.doc);
    }
    return ord;
  }
}