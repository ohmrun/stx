package stx.assert.eq.term;

import tink.core.Noise in NoiseT;

class Noise extends EqCls<NoiseT>{
  public function new(){}
  public function comply(a:NoiseT,b:NoiseT):Equaled{
    return Equaled.AreEqual;
  }
}