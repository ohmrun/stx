package stx.assert.glot.eq;

import eu.ohmrun.glot.expr.GTypePath as GTypePathT;

class GTypePath extends stx.assert.eq.term.Base<GTypePathT> {
  public function comply(lhs:GTypePathT,rhs:GTypePathT){
    var eq = Eq.String().comply(lhs.name,rhs.name);
    if(eq.is_ok()){
      eq = Eq.Cluster(Eq.String()).comply(lhs.pack,rhs.pack);
    }
    if(eq.is_ok()){
      eq = Eq.NullOr(Eq.String()).comply(lhs.sub,rhs.sub);
    }
    if(eq.is_ok()){
      eq = Eq.NullOr(Eq.Cluster(new GTypeParam())).comply(lhs.params,rhs.params);
    }
    return eq;
  }
}