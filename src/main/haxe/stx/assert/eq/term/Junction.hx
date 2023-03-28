package stx.assert.eq.term;

import stx.nano.Junction as TJunction;

class Junction<T> extends EqCls<TJunction<T>>{
  final inner : Eq<T>;
  public function new(inner){
    this.inner = inner;
  }
  public function comply(lhs:TJunction<T>,rhs:TJunction<T>){
    return switch([lhs,rhs]){
      case [There(vI),There(vII)]                       : new stx.assert.eq.term.Register().comply(vI,vII);
      case [Whole(vI),Whole(vII)]                       : inner.comply(vI,vII);
      case [x,y]                                        : Eq.EnumValueIndex().comply(x,y);
    }
  }
}