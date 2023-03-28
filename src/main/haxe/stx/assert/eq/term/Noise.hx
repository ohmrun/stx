package stx.assert.eq.term;

import tink.core.Noise in NoiseT;

class Noise implements EqApi<NoiseT> extends Clazz{
  public function comply(a:NoiseT,b:NoiseT):Equaled{
    return Equaled.AreEqual;
  }
}