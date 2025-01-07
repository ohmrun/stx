package stx.assert.glot.ord;

import eu.ohmrun.glot.expr.GAbstractFlag.GAbstractFlagSum;
import eu.ohmrun.glot.expr.GAbstractFlag as GAbstractFlagT;

class GAbstractFlag extends stx.assert.Ord.OrdCls<GAbstractFlagT>{
  public function new(){}
  static public var instance(get,null) : GAbstractFlag;
  static private function get_instance(){
    return instance == null ? instance = new GAbstractFlag() : instance;
  }
  public function comply(lhs:GAbstractFlagT,rhs:GAbstractFlagT){
    return switch([lhs,rhs]){
      case [GAbEnum,GAbEnum]            : OrderedSum.NotLessThan;
      case [GAbFrom(ctI),GAbFrom(ctII)] : GComplexType.instance.comply(ctI,ctII);
      case [GAbTo(ctI),GAbTo(ctII)]     : GComplexType.instance.comply(ctI,ctII);
      default                           : Ord.EnumValueIndex().comply(lhs,rhs);
    }
  }
}