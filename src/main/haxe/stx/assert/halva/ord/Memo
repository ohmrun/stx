package stx.assert.halva.ord;

import eu.ohmrun.halva.core.Memo as TMemo;

class Memo<T> extends OrdCls<TMemo<T>>{
  final inner : Ord<T>;
  public function new(inner){
    this.inner = inner;
  }
  public function comply(lhs:TMemo<T>,rhs:TMemo<T>){
    return switch([lhs.frozen,rhs.frozen]){
      case [false,true]                         : LessThan;
      default                                   : 
        this.inner.comply(lhs.value,rhs.value);
    }
  }
}
