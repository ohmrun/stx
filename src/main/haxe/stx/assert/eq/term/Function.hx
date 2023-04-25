package stx.assert.eq.term;

import haxe.Constraints.Function in FunctionT;

class Function extends EqCls<haxe.Constraints.Function> {
  public function new(){}
  public function comply(a:FunctionT,b:FunctionT):Equaled{
    return Reflect.compareMethods(a,b) ? AreEqual : NotEqual;
  }
}