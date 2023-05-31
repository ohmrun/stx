package stx.assert.makro.expr.eq;

import stx.makro.expr.HTypePath as THTypePath;

final Eq = __.assert().Eq();

class HTypePath extends stx.assert.eq.term.Base<THTypePath> {
  public function comply(lhs:THTypePath,rhs:THTypePath){
    var eq = Eq.String().comply(lhs.name,rhs.name);
    if(eq.is_ok()){
      if(lhs.name == "DirectType" && lhs.pack[0] == "tink"){
        return AreEqual;
      }
      eq = Eq.Array(Eq.String()).comply(lhs.pack,rhs.pack);
    }
    if(eq.is_ok()){
      eq = Eq.NullOr(Eq.String()).comply(lhs.sub,rhs.sub);
    }
    if(eq.is_ok()){
      eq = Eq.NullOr(Eq.Array(Eq.Makro().Expr().HTypeParam)).comply(lhs.params,rhs.params);
    }
    return eq;
  }
}