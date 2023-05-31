package stx.assert.makro.type.comparable;

import stx.makro.type.HType as THType;

final Eq  = __.assert().Eq();
final Ord = __.assert().Ord();

class HType extends ComparableCls<THType>{
  public function new(){}
  public function eq(){
    return Eq.Makro().Type().HType;
  }
  public function lt(){
    return Ord.Makro().Type().HType;
  }
}