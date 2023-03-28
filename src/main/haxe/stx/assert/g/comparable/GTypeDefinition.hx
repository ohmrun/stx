package stx.assert.g.comparable;

import stx.g.lang.expr.GTypeDefinition as GTypeDefinitionT;

class GTypeDefinition extends ComparableCls<GTypeDefinitionT>{
  public function new(){}
  public function eq():Eq<GTypeDefinitionT>{
    return new stx.assert.g.eq.GTypeDefinition();
  }
  public function lt():Ord<GTypeDefinitionT>{
    return new stx.assert.g.ord.GTypeDefinition();
  }
}