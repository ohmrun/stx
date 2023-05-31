package eu.ohmrun.glot.expr;

final Expr = __.glot().Expr;

class GFunctionCtr extends Clazz{
  public function Make(args:CTR<GFunctionArgCtr,Cluster<GFunctionArg>>,?ret:CTR<GComplexTypeCtr,GComplexType>,?expr:CTR<GExprCtr,GExpr>,?params:CTR<GTypeParamDeclCtr,Cluster<GTypeParamDecl>>){
    return GFunction.make(
      args(Expr.GFunctionArg),
      __.option(ret).map(f -> f(Expr.GComplexType)).defv(null),
      __.option(expr).map(f -> f(Expr.GExpr)).defv(null),
      __.option(params).map(f -> f(Expr.GTypeParamDecl)).defv(null)
    );
  }
}
typedef GFunctionDef = {
	final args    : Cluster<GFunctionArg>;
	final ret     : Null<GComplexType>;
	final expr    : Null<GExpr>;
	final ?params : Cluster<GTypeParamDecl>;
}
@:using(eu.ohmrun.glot.expr.GFunction.GFunctionLift)
@:forward abstract GFunction(GFunctionDef) from GFunctionDef to GFunctionDef{
    static public var _(default,never) = GFunctionLift;
  public function new(self) this = self;
  @:noUsing static public function lift(self:GFunctionDef):GFunction return new GFunction(self);
  @:noUsing static public function make(args:Cluster<GFunctionArg>,?ret:GComplexType,?expr:GExpr,?params:Cluster<GTypeParamDecl>){
    return lift({
      args    : args,
      ret     : ret,
      expr    : expr,
      params  : params
    });
  }
  public function prj():GFunctionDef return this;
  private var self(get,never):GFunction;
  private function get_self():GFunction return lift(this);
  
  public function toSource():GSource{
		return Printer.ZERO.printFunction(this);
	}
}
class GFunctionLift{
  #if macro
  static public function to_macro_at(self:GFunction,pos:Position):Function{
    return @:privateAccess {
      args    : self.args.map(arg -> arg.to_macro_at(pos)).prj(),
      ret     : __.option(self.ret).map(ret -> ret.to_macro_at(pos)).defv(null),
      expr    : __.option(self.expr).map(x -> x.to_macro_at(pos)).defv(null),
      params  : __.option(self.params).map(x -> x.map(y -> y.to_macro_at(pos)).prj()).defv([])
    }
  }
  #end
}