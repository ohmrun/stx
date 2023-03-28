package stx.makro.expr;

@:using(stx.makro.expr.HComplexType.HComplexTypeLift)
@:forward abstract HComplexType(StdComplexType) from StdComplexType to StdComplexType{
  public function new(self) this = self;
  @:noUsing static public function lift(self:StdComplexType):HComplexType return new HComplexType(self);

  public function prj():StdComplexType return this;
  private var self(get,never):HComplexType;
  private function get_self():HComplexType return lift(this);

  @:from static public function fromStdTypePath(self:StdTypePath):HComplexType{
    return lift(TPath(self));
  }
  @:from static public function fromHTypePath(self:HTypePath):HComplexType{
    return lift(TPath(self.prj()));
  }
  @:noUsing static public function TPath(self:HTypePath){
    return fromHTypePath(self);
  }
  @:noUsing static public function TFunction(args:Cluster<HComplexType>,ret:HComplexType){
    return lift(StdComplexType.TFunction(args.prj(),ret.prj()));
  }
  @:noUsing static public function TAnonymous(args:Cluster<HField>){
    return lift(StdComplexType.TAnonymous(args.prj()));
  }
  @:noUsing static public function TParent(t:HComplexType){
    return lift(StdComplexType.TParent(t.prj()));
  }
  @:noUsing static public function TExtend(a:Cluster<HTypePath>,fields:Cluster<HField>){
    return lift(StdComplexType.TExtend(a.prj(),fields.prj()));
  }
  @:noUsing static public function TOptional(t:HComplexType){
    return lift(StdComplexType.TOptional(t.prj()));
  }
  @:noUsing static public function TNamed(n:String,t:HComplexType){
    return lift(StdComplexType.TNamed(n,t.prj()));
  }
  @:noUsing static public function TIntersection(tl:Cluster<HComplexType>){
    return lift(StdComplexType.TIntersection(tl.prj()));
  }
  public function toTypeParam(){
    return HTypeParam.fromStdComplexType(this);
  }
}
class HComplexTypeLift{

}