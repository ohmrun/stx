package stx.assert.halva.ord;

import eu.ohmrun.halva.LVar as TLVar;

class LVar<T> extends OrdCls<TLVar<T>>{
  final inner : Ord<T>;
  public function new(inner){
    this.inner = inner;
  }
  public function comply(lhs:TLVar<T>,rhs:TLVar<T>){
    return switch([lhs,rhs]){
      case [BOT,BOT]                            : NotLessThan;
      case [HAS(vI,bI),HAS(vII,bII)]            : 
        var ord = Ord.Bool().comply(bI,bII);
        if(ord.is_not_less_than()){
          ord = inner.comply(vI,vII);
        }
        ord;
      case [TOP,TOP]                            : NotLessThan;
      case [x,y]                                : Ord.EnumValueIndex().comply(x,y);
    }
  }
}
