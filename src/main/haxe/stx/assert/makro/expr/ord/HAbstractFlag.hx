package stx.assert.makro.expr.ord;
import stx.makro.expr.HAbstractFlag as HAbstractFlagT;

final Ord = __.assert().Ord();

class HAbstractFlag extends OrdCls<HAbstractFlagT>{
  public function new(){}
  public function comply(lhs:HAbstractFlagT,rhs:HAbstractFlagT){
    return Ord.EnumValueIndex().comply(lhs,rhs);
  }
}