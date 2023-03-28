package stx.makro.expr;


@:using(stx.makro.expr.HFunctionArg.HFunctionArgLift)
abstract HFunctionArg(StdFunctionArg) from StdFunctionArg to StdFunctionArg{
  static public var _(default,never) = HFunctionArgLift;
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