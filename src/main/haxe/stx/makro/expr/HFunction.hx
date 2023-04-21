package stx.makro.expr;

/*
  typedef Function = {
    var args:Array<FunctionArg>;
    var ?ret:ComplexType;
    var ?expr:Expr;
    var ?params:Array<TypeParamDecl>;
  }
*/
@:using(stx.makro.expr.HFunction.HFunctionLift)
abstract HFunction(Function) from Function to Function{
  public function new(self) this = self;
  @:noUsing static public function lift(self:Function):HFunction return new HFunction(self);
  @:noUsing static public function make(args:Cluster<HFunctionArg>,?params,?expr,?ret){
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