package stx.assert.comparable.term;

import stx.nano.Primitive in PrimitiveT;

class Primitive extends ComparableCls<PrimitiveT>{
  public function new(){}
  public function eq() : Eq<PrimitiveT>{
    return Eq.Primitive();
  }
  public function lt():Ord<PrimitiveT>{
    return Ord.Primitive();
  }
}