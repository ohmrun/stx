package stx.makro.expr;

final Expr = __.makro().expr;

class HFunctionArgCtr extends Clazz{
  public function Make(name:String,type:CTR<HComplexTypeCtr,HComplexType>,?opt:Bool,?value:CTR<HExprCtr,HExpr>,?meta:CTR<HMetadataEntryCtr,HMetadata>){
    return HFunctionArg.lift({
      name  : name,
      type  : type.apply(Expr.HComplexType),
      opt   : opt,
      value : __.option(value).map(f -> f.apply(Expr.HExpr).prj()).defv(null),
      meta  : __.option(meta).map(f -> f.apply(Expr.HMetadataEntry)).defv(null)
    });
  }
}

typedef HFunctionArgDef = StdFunctionArg;

@:using(stx.makro.expr.HFunctionArg.HFunctionArgLift)
@:forward abstract HFunctionArg(StdFunctionArg) from StdFunctionArg to StdFunctionArg{
  
  public inline function new(self:StdFunctionArg) this = self;
  static inline public function lift(self:StdFunctionArg):HFunctionArg return new HFunctionArg(self);
  static inline public function make(name,type:HComplexType,?opt:Bool,?value:Null<Expr>,?meta){
    return lift({
      name    : name,
      type    : type,
      opt     : opt,
      value   : value,
      meta    : meta
    });
  }
  public function prj():StdFunctionArg return this;
  private var self(get,never):HFunctionArg;
  private function get_self():HFunctionArg return lift(this);
}
class HFunctionArgLift{
  static public inline function lift(self:FunctionArg):HFunctionArg{
    return HFunctionArg.lift(self);
  }
}