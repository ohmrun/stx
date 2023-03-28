package stx.assert.eq.term;

import haxe.Constraints.Function in FunctionT;

class Function implements EqApi<haxe.Constraints.Function> extends Clazz{
  public function comply(a:FunctionT,b:FunctionT):Equaled{
    return Reflect.compareMethods(a,b) ? AreEqual : NotEqual;
  }
}