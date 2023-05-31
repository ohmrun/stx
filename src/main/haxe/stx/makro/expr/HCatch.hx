package stx.makro.expr;

final Expr = __.makro().expr;

class HCatchCtr extends Clazz{
  public function Make(name:String,expr:CTR<HExprCtr,HExpr>,type:CTR<HComplexTypeCtr,HComplexType>){
    return HCatch.make(
      name,
      expr(Expr.HExpr),
      __.option(type).map(f -> f(Expr.HComplexType)).defv(null)
    );
  }
}

typedef HCatchDef = haxe.macro.Expr.Catch;

@:using(stx.makro.expr.HCatch.HCatchLift)
@:forward abstract HCatch(HCatchDef) from HCatchDef to HCatchDef{
  static public var _(default,never) = HCatchLift;
  public inline function new(self:HCatchDef) this = self;
  @:noUsing static inline public function lift(self:HCatchDef):HCatch return new HCatch(self);

  @:noUsing static public function make(name:String,expr:HExpr,?type:HComplexType){
    return lift({
      name  : name,
      expr  : expr.toExpr(),
      type  : type
    });
  }

  public function prj():HCatchDef return this;
  private var self(get,never):HCatch;
  private function get_self():HCatch return lift(this);
}
class HCatchLift{
  static public inline function lift(self:HCatchDef):HCatch{
    return HCatch.lift(self);
  }
}