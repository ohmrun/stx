package stx.assert.glot.comparable;

import eu.ohmrun.glot.expr.GTypeDefinition as GTypeDefinitionT;

class GTypeDefinition extends ComparableCls<GTypeDefinitionT>{
  public function new(){}
  public function eq():Eq<GTypeDefinitionT>{
    return new stx.assert.glot.eq.GTypeDefinition();
  }
  public function lt():Ord<GTypeDefinitionT>{
    return new stx.assert.glot.ord.GTypeDefinition();
  }
}