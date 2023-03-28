package stx.assert.ord.term;

import stx.nano.Primitive in PrimitiveT;

class Primitive extends OrdCls<PrimitiveT>{
  public function new(){}
  public function comply(lhs:PrimitiveT,rhs:PrimitiveT):Ordered{
    return switch([lhs,rhs]){
      case [PNull,PNull]                                                : NotLessThan;
      case [PBool(lhs),PBool(rhs)]                                      : Ord.Bool().comply(lhs,rhs);
      case [PSprig(Byteal(NInt(lhs))),PSprig(Byteal(NInt(rhs)))]        : Ord.Int().comply(lhs,rhs);
      case [PSprig(Byteal(NInt64(lhs))),PSprig(Byteal(NInt64(rhs)))]    : Ord.Int64().comply(lhs,rhs);
      case [PSprig(Byteal(NFloat(lhs))),PSprig(Byteal(NFloat(rhs)))]    : Ord.Float().comply(lhs,rhs);
      case [PSprig(Textal(lhs)),PSprig(Textal(rhs))]                    : Ord.String().comply(lhs,rhs);
      default                            : StdType.enumIndex(lhs) < StdType.enumIndex(rhs) ? LessThan : NotLessThan;
    }
  }
}
