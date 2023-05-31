package stx.makro.expr;

final Expr = __.makro().expr;

class HCaseCtr extends Clazz{
  public function Make(values:CTR<HExprCtr,Array<HExpr>>,?guard:CTR<HExprCtr,HExpr>,?expr:CTR<HExprCtr,HExpr>){
    final ctr = Expr.HExpr;
    return HCase.make(
      values(ctr),
      __.option(guard).map(f -> f(ctr)).defv(null),
      __.option(expr).map(f -> f(ctr)).defv(null)
    );
  }
}
typedef HCaseDef = haxe.macro.Expr.Case;

@:using(stx.makro.expr.HCase.HCaseLift)
@:forward abstract HCase(HCaseDef) from HCaseDef to HCaseDef{
  static public var _(default,never) = HCaseLift;
  public inline function new(self:HCaseDef) this = self;
  @:noUsing static inline public function lift(self:HCaseDef):HCase return new HCase(self);

  @:noUsing static public function make(values:Array<HExpr>,?guard:HExpr,?expr:HExpr){
    return lift({
      values  : values.map(x -> x.toExpr()),
      guard   : __.option(guard).map(x -> x.toExpr()).defv(null),
      expr    : __.option(expr).map(x -> x.toExpr()).defv(null)
    });
  }
  public function prj():HCaseDef return this;
  private var self(get,never):HCase;
  private function get_self():HCase return lift(this);
}
class HCaseLift{
  static public inline function lift(self:HCaseDef):HCase{
    return HCase.lift(self);
  }
} 