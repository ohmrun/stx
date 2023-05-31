package stx.makro.expr;

final Expr = __.makro().expr;

class HObjectFieldCtr extends Clazz{
  public function Make(field:String,?expr:CTR<HExprCtr,HExpr>,?quotes){
    return HObjectField.make(
      field,
      __.option(expr).map(f -> f(Expr.HExpr)).defv(null),
      quotes
    );
  }
}

typedef HObjectFieldDef = haxe.macro.Expr.ObjectField;

@:using(stx.makro.expr.HObjectField.HObjectFieldLift)
@:forward abstract HObjectField(haxe.macro.Expr.ObjectField) from haxe.macro.Expr.ObjectField to haxe.macro.Expr.ObjectField{
  static public var _(default,never) = HObjectFieldLift;
  public inline function new(self:haxe.macro.Expr.ObjectField) this = self;
  @:noUsing static inline public function lift(self:haxe.macro.Expr.ObjectField):HObjectField return new HObjectField(self);
  @:noUsing static public function make(field:String,expr:HExpr,?quotes:HQuoteStatus){
    return lift({field:field,expr:expr.prj(),quotes:quotes});
  }
  public function prj():haxe.macro.Expr.ObjectField return this;
  private var self(get,never):HObjectField;
  private function get_self():HObjectField return lift(this);
}
class HObjectFieldLift{
  static public inline function lift(self:haxe.macro.Expr.ObjectField):HObjectField{
    return HObjectField.lift(self);
  }
}