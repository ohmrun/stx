package stx.assert.eq.term;

import stx.pico.Nada in NadaT;

class Nada extends EqCls<NadaT>{
  public function new(){}
  public function comply(a:NadaT,b:NadaT):Equaled{
    return Equaled.AreEqual;
  }
}