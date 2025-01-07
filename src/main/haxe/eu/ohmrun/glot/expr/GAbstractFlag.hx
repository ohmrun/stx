package eu.ohmrun.glot.expr;


class GAbstractFlagCtr extends Clazz{
  static public var instance(get,null) : GAbstractFlagCtr;
  static private function get_instance(){
    return instance == null ? instance = new GAbstractFlagCtr() : instance;
  }  public function Enum(){
    return GAbEnum;
  }
  public function From(ctr:CTR<GComplexTypeCtr,GComplexType>){
    return GAbFrom(ctr.apply(GComplexTypeCtr.instance)); 
  }
  public function To(ctr:CTR<GComplexTypeCtr,GComplexType>){
    return GAbTo(ctr.apply(GComplexTypeCtr.instance));
  }
}
enum GAbstractFlagSum{
	GAbEnum;
	GAbFrom(ct:GComplexType);
	GAbTo(ct:GComplexType);
}
@:using(eu.ohmrun.glot.expr.GAbstractFlag.GAbstractFlagLift)
abstract GAbstractFlag(GAbstractFlagSum) from GAbstractFlagSum to GAbstractFlagSum{

}
class GAbstractFlagLift{
  #if macro
  static public function to_macro_at(self:GAbstractFlag,pos:Position){
    return switch(self){
      case GAbEnum     : AbEnum;
      case GAbFrom(ct) : AbFrom(ct.to_macro_at(pos));
      case GAbTo(ct)   : AbTo(ct.to_macro_at(pos));
    }
  }
  #end
}