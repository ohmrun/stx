package eu.ohmrun.glot.expr;

final Expr = __.glot().Expr;

class GObjectFieldCtr extends Clazz{
  public function Make(field:String,?expr:CTR<GExprCtr,GExpr>,?quotes){
    return GObjectField.make(
      field,
      __.option(expr).map(f -> f(Expr.GExpr)).defv(null),
      quotes
    );
  }
}
typedef GObjectFieldDef = {
	var field:String;
	var expr:GExpr;
	var ?quotes:GQuoteStatus;
}
@:using(eu.ohmrun.glot.expr.GObjectField.GObjectFieldLift)
@:forward abstract GObjectField(GObjectFieldDef) from GObjectFieldDef to GObjectFieldDef{
  static public var _(default,never) = GObjectFieldLift;
  public function new(self) this = self;
  @:noUsing static public function lift(self:GObjectFieldDef):GObjectField return new GObjectField(self);

  @:noUsing static public function make(field:String,expr:GExpr,?quotes:GQuoteStatus){
    return lift({field:field,expr:expr,quotes:quotes});
  }
  public function prj():GObjectFieldDef return this;
  private var self(get,never):GObjectField;
  private function get_self():GObjectField return lift(this);

  public function toSource():GSource{
		return Printer.ZERO.printObjectField(this);
	}
}
class GObjectFieldLift{
  #if macro
  static public function to_macro_at(self:GObjectField,pos:Position){
    return {
      field  : self.field,
      expr   : self.expr.to_macro_at(pos),
      quotes : __.option(self.quotes).map(x -> x.to_macro_at(pos)).defv(null)
    }
  }
  #end
}