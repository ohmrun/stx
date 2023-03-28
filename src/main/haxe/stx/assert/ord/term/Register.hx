package stx.assert.ord.term;

import stx.nano.Register as TRegister;

class Register extends OrdCls<TRegister>{
  public function new(){}
  public function comply(lhs:TRegister,rhs:TRegister){
    return lhs < rhs ? LessThan : NotLessThan;
  }
}
