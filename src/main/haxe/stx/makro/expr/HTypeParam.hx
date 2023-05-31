package stx.makro.expr;

final _Expr = __.makro().expr;

class HTypeParamCtr extends Clazz{
  public function CType(type:CTR<HComplexTypeCtr,HComplexType>){
    return HTypeParam.lift(TPType(type.apply(_Expr.HComplexType)));
  }
  public function ComplexType(type:CTR<HComplexTypeCtr,HComplexType>){
    return HTypeParam.lift(TPType(type.apply(_Expr.HComplexType)));
  }
  public function Expr(expr:CTR<HExprCtr,HExpr>){
    return HTypeParam.lift(TPExpr(expr.apply(_Expr.HExpr).prj()));
  }
}

typedef HTypeParamDef = StdTypeParam;

@:forward abstract HTypeParam(StdTypeParam) from StdTypeParam to StdTypeParam{
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