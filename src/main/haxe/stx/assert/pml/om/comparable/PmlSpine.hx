package stx.assert.pml.om.comparable;

import eu.ohmrun.pml.term.PmlSpine in TPmlSpine;

final Eq  = __.assert().Eq();
final Ord = __.assert().Ord();

class PmlSpine extends stx.assert.Comparable.ComparableCls<TPmlSpine>{
  public function new(){}
  public function eq():Eq<TPmlSpine>{
    return Eq.PmlSpine();
  }
  public function lt():Ord<TPmlSpine>{
    return Ord.PmlSpine();
  }
}