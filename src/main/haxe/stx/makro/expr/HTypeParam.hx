package stx.makro.expr;

abstract HTypeParam(StdTypeParam) from StdTypeParam to StdTypeParam{
  public function new(self) this = self;
  @:noUsing static public function lift(self:StdTypeParam):HTypeParam return new HTypeParam(self);

  public function prj():StdTypeParam return this;
  private var self(get,never):HTypeParam;
  private function get_self():HTypeParam return lift(this);

  @:from static public function fromStdComplexType(self:StdComplexType){
    return lift(TPType(self));
  }
  @:from static public function fromStdTypePath(self:StdTypePath):HTypeParam{
    return fromStdComplexType(HComplexType.fromStdTypePath(self));
  }
  @:from static public function fromHTypePath(self:HTypePath):HTypeParam{
    return fromStdComplexType(HComplexType.fromStdTypePath(self));
  }
}