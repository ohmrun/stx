package stx.makro.expr.typed;

final Expr = __.makro().expr;

class HTypedExprCtr extends Clazz{
  // public function Make(def:CTR<HTypedExprdefCtr,HTypedExprdef>,?pos:Position){
  //   return HTypedExpr.make(def.apply(new HTypedExprdefCtr()),pos);
  // }
}

typedef HTypedExprDef = haxe.macro.Type.TypedExpr;

@:using(stx.makro.expr.typed.HTypedExpr.HTypedExprLift)
@:forward abstract HTypedExpr(StdExpr){
  static public var ZERO(default,never) : HTypedExpr  = lift( {expr : EBlock([]), pos : null } );
  static public var _(default,never) = HTypedExprLift;
  public function new(self) this = self;
  @:noUsing static public function lift(self:StdExpr):HTypedExpr return new HTypedExpr(self);
  public function prj():StdExpr return this;
  private var self(get,never):HTypedExpr;
  private function get_self():HTypedExpr return lift(this);

  // @:noUsing static public function lift(self:haxe.macro.Expr):HTypedExpr{
  //   return fromExpr(self);
  // }
}

class HTypedExprLift{
  
}