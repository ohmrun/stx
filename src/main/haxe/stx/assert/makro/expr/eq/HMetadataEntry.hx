package stx.assert.makro.expr.eq;

import stx.makro.expr.HMetadataEntry as THMetadataEntry;

final Eq = __.assert().Eq();

class HMetadataEntry extends EqCls<THMetadataEntry>{

  public function new(){}

  public function comply(a:THMetadataEntry,b:THMetadataEntry):Equaled{
    var eq = Eq.String().comply(a.name,b.name);
    if(eq.is_ok()){
      eq = Eq.NullOr(Eq.Array(Eq.Makro().Expr().Expr)).comply(a.params,b.params);
    }
    if(eq.is_ok()){
      eq = Eq.Makro().Expr().Position.comply(a.pos,b.pos);
    }
    return eq;
  }
}