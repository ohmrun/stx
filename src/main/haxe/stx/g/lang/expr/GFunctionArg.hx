package stx.g.lang.expr;

class GFunctionArgCtr extends Clazz{
  static public function unit(){
    return new GFunctionArgCtr();
  }
  private function lift(self:GFunctionArgDef):GFunctionArg{
    return GFunctionArg.lift(self);
  }
  public function Make(name:String,type:CTR<GComplexTypeCtr,GComplexType>,?opt:Bool,?value:CTR<GExprCtr,GExpr>,?meta:CTR<GMetadataEntryCtr,GMetadata>){
    return lift({
      name  : name,
      type  : type(GComplexType.__),
      opt   : opt,
      value : __.option(value).map(f -> f(GExpr.__)).defv(null),
      meta  : __.option(meta).map(f -> f(GMetadataEntry.__)).defv(null)
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
@:using(stx.g.lang.expr.GFunctionArg.GFunctionArgLift)
@:forward abstract GFunctionArg(GFunctionArgDef) from GFunctionArgDef to GFunctionArgDef{
  static public var __(default,never) = new GFunctionArgCtr();
  public function new(self) this = self;
  @:noUsing static public function lift(self:GFunctionArgDef):GFunctionArg return new GFunctionArg(self);
  @:noUsing static public function make(name:String,type:GComplexType,?opt:Bool,?value:GExpr,?meta:GMetadata){
    return lift({
      name    : name,
      type    : type,
      opt     : opt,
      value   :value,
      meta  : meta
    });
  }
  public function prj():GFunctionArgDef return this;
  private var self(get,never):GFunctionArg;
  private function get_self():GFunctionArg return lift(this);

  public function toSource():GSource{
		return Printer.ZERO.printFunctionArg(this);
	}
}
class GFunctionArgLift{
  static public function to_macro_at(self:GFunctionArg,pos:Position):FunctionArg{
    return {
      name    : self.name,
      type    : __.option(self.type).map(e -> e.to_macro_at(pos)).defv(null),
      opt     : self.opt,
      value   : __.option(self.value).map(e -> e.to_macro_at(pos)).defv(null),
      meta    : __.option(self.meta).map(x -> x.to_macro_at(pos)).defv(null)
    }
  }
}
