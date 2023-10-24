package stx.makro.expr;

final Expr = __.makro().expr;

class HFunctionCtr extends Clazz{
  public function Make(args:CTR<HFunctionArgCtr,Array<HFunctionArg>>,?ret:Null<CTR<HComplexTypeCtr,HComplexType>>,?expr:CTR<HExprCtr,HExpr>,?params:CTR<HTypeParamDeclCtr,Array<HTypeParamDecl>>){
    return HFunction.make(
      args.apply(Expr.HFunctionArg),
      __.option(params).map(f -> f.apply(Expr.HTypeParamDecl)).defv(null),
      __.option(expr).map(f -> f.apply(Expr.HExpr)).defv(null),
      __.option(ret).map(f -> f.apply(Expr.HComplexType)).defv(null)
    );
  }
}
/*
  typedef Function = {
    var args:Array<FunctionArg>;
    var ?ret:ComplexType;
    var ?expr:Expr;
    var ?params:Array<TypeParamDecl>;
  }
*/
typedef HFunctionDef = Function;
@:using(stx.makro.expr.HFunction.HFunctionLift)
@:forward abstract HFunction(Function) from Function to Function{
  public function new(self) this = self;
  @:noUsing static public function lift(self:Function):HFunction return new HFunction(self);
  @:noUsing static public function make(args:Array<HFunctionArg>,?params:Array<HTypeParamDecl>,?expr:HExpr,?ret:HComplexType){
    return lift({
      args    : args.prj(),
      params  : __.option(params).defv([]),
      expr    : __.option(expr).defv(HExpr.ZERO).prj(),
      ret     : ret 
    });
  }
  public function prj():Function return this;
  private var self(get,never):HFunction;
  private function get_self():HFunction return lift(this);
}
class HFunctionLift{

}