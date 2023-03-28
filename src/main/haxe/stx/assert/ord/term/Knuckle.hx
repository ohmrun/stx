package stx.assert.ord.term;

import stx.nano.Knuckle as TKnuckle;

class Knuckle extends OrdCls<TKnuckle>{
  public function new(){}
  public function comply(lhs:TKnuckle,rhs:TKnuckle){
    return switch([lhs,rhs]){
      case [Ordinal(vI),Ordinal(vII)]                 : vI < vII ? LessThan : NotLessThan;
      case [Nominal(vI,sI),Nominal(vII,sII)]          : 
        var ord = Ord.String().comply(vI,vII);
        if(ord.is_not_less_than()){
          ord = Ord.Register().comply(sI,sII);
        }
        ord;
      case [x,y]                                      : Ord.EnumValueIndex().comply(x,y);
    }
  }
}
