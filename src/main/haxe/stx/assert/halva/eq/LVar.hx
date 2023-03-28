package stx.assert.halva.eq;

import eu.ohmrun.halva.LVar as TLVar;

class LVar<T> extends EqCls<TLVar<T>>{
  final inner : Eq<T>;
  public function new(inner){
    this.inner = inner;
  }
  public function comply(lhs:TLVar<T>,rhs:TLVar<T>){
    return switch([lhs,rhs]){
      case [BOT,BOT]                            : AreEqual;
      case [HAS(vI,bI),HAS(vII,bII)]            : 
        var eq = Eq.Bool().comply(bI,bII);
        if(eq.is_equal()){
          eq = inner.comply(vI,vII);
        }
        eq;
      case [TOP,TOP]                            : AreEqual;
      case [x,y]                                : Eq.EnumValueIndex().comply(x,y);
    }
  }
}
