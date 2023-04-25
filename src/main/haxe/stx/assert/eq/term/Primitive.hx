package stx.assert.eq.term;

import stx.nano.Primitive in PrimitiveT;

class Primitive extends EqCls<PrimitiveT>{
  public function new(){}
  public function comply(lhs:PrimitiveT,rhs:PrimitiveT):Equaled{
    return switch([lhs,rhs]){
      case [PNull,PNull]                                                  : AreEqual;
      case [PBool(lhs),PBool(rhs)]                                        : Eq.Bool().comply(lhs,rhs);
      case [PSprig(Byteal(NInt(lhs))),PSprig(Byteal(NInt(rhs)))]          : Eq.Int().comply(lhs,rhs);
      case [PSprig(Byteal(NInt64(lhs))),PSprig(Byteal(NInt64(rhs)))]      : Eq.Int64().comply(lhs,rhs);
      case [PSprig(Byteal(NFloat(lhs))),PSprig(Byteal(NFloat(rhs)))]      : Eq.Float().comply(lhs,rhs);
      case [PSprig(Textal(lhs)),PSprig(Textal(rhs))]                      : Eq.String().comply(lhs,rhs);
      default                            : StdType.enumIndex(lhs) == StdType.enumIndex(rhs) ? AreEqual : NotEqual;
    }
  }
}