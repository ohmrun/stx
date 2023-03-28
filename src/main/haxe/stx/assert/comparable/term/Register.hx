package stx.assert.comparable.term;

import stx.nano.Register in TRegister;

class Register extends ComparableCls<TRegister>{
  public function new(){}
  public function eq() : Eq<TRegister>{
    return Eq.Register();
  }
  public function lt() : Ord<TRegister>{
    return Ord.Register();
  }
}