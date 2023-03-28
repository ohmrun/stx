package stx.assert.eq.term;

import stx.nano.Register as TRegister;

class Register extends EqCls<TRegister>{
  public function new(){}
  public function comply(lhs:TRegister,rhs:TRegister){
    return lhs == rhs ? AreEqual : NotEqual;
  }
}
