package eu.ohmrun.glot.expr;

final Expr = __.glot().Expr;

class GFunctionArgCtr extends Clazz{
  public function Make(name:String,type:CTR<GComplexTypeCtr,GComplexType>,?opt:Bool,?value:CTR<GExprCtr,GExpr>,?meta:CTR<GMetadataEntryCtr,GMetadata>){
    return GFunctionArg.lift({
      name  : name,
      type  : type(Expr.GComplexType),
      opt   : opt,
      value : __.option(value).map(f -> f(Expr.GExpr)).defv(null),
      meta  : __.option(meta).map(f -> f(Expr.GMetadataEntry)).defv(null)
    });
  }
}
typedef GFunctionArgDef = {
	final name    : String;
  final type    : Null<GComplexType>;
	final ?opt    : Bool;
	final ?value  : Null<GExpr>;
	final ?meta   : GMetadata;
}
@:using(eu.ohmrun.glot.expr.GFunctionArg.GFunctionArgLift)
@:forward abstract GFunctionArg(GFunctionArgDef) from GFunctionArgDef to GFunctionArgDef{
    public function new(self) this = self;
  @:noUsing static public function lift(self:GFunctionArgDef):GFunctionArg return new GFunctionArg(self);
  @:noUsing static public function make(name:String,type:GComplexType,?opt:Bool,?value:GExpr,?meta:GMetadata){
    return GFunctionArg.lift({
      name    : name,
      type    : type,
      opt     : opt,
      value   :value,
      meta  : meta
    });
  }
  public function prj():GFunctionArgDef return this;
  private var self(get,never):GFunctionArg;
  private function get_self():GFunctionArg return GFunctionArg.lift(this);

  public function toSource():GSource{
		return Printer.ZERO.printFunctionArg(this);
	}
}
class GFunctionArgLift{
  #if macro
  static public function to_macro_at(self:GFunctionArg,pos:Position):FunctionArg{
    return {
      name    : self.name,
      type    : __.option(self.type).map(e -> e.to_macro_at(pos)).defv(null),
      opt     : self.opt,
      value   : __.option(self.value).map(e -> e.to_macro_at(pos)).defv(null),
      meta    : __.option(self.meta).map(x -> x.to_macro_at(pos)).defv(null)
    }
  }
  #end
}

