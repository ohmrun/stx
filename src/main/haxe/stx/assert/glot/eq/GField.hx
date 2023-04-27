package stx.assert.glot.eq;

import eu.ohmrun.glot.expr.GField as GFieldT;

class GField extends stx.assert.eq.term.Base<GFieldT> {
  public function comply(lhs:GFieldT,rhs:GFieldT){
    var eq = Eq.String().comply(lhs.name,rhs.name);
    if(eq.is_ok()){
      eq = new GFieldType().comply(lhs.kind,rhs.kind);
    }
    if(eq.is_ok()){
      final ctr = () -> RedBlackSet.make(Comparable.Anon(new GAccess(),new stx.assert.glot.ord.GAccess()));
      var lset = ctr();
          lset = lset.concat(__.option(lhs.access).defv([].imm()));
      var rset = ctr();
          rset = rset.concat(__.option(rhs.access).defv([].imm()));
      eq = lset.equals(rset);
    }
    if(eq.is_ok()){
      eq = new GFieldType().comply(lhs.kind,rhs.kind);
    }
    if(eq.is_ok()){
      eq = Eq.NullOr(new GMetadata()).comply(lhs.meta,rhs.meta);
    }
    if(eq.is_ok()){
      eq = Eq.NullOr(Eq.String()).comply(lhs.doc,rhs.doc);
    }
    return eq;
  }
}