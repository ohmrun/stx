package eu.ohmrun.glot.expr;

final _Expr = __.glot().Expr;

class GTypeParamCtr extends Clazz{
  public function CType(type:CTR<GComplexTypeCtr,GComplexType>){
    return GTypeParam.lift(GTPType(type.apply(_Expr.GComplexType)));
  }
  public function ComplexType(type:CTR<GComplexTypeCtr,GComplexType>){
    return GTypeParam.lift(GTPType(type.apply(_Expr.GComplexType)));
  }
  public function Expr(expr:CTR<GExprCtr,GExpr>){
    return GTypeParam.lift(GTPExpr(expr.apply(_Expr.GExpr)));
  }
}
enum GTypeParamSum {
	GTPType( t : GComplexType );
	GTPExpr( e : GExpr );
}
@:using(eu.ohmrun.glot.expr.GTypeParam.GTypeParamLift)
abstract GTypeParam(GTypeParamSum) from GTypeParamSum to GTypeParamSum{
  public function new(self) this = self;
  @:noUsing static public function lift(self:GTypeParamSum):GTypeParam return new GTypeParam(self);

  public function prj():GTypeParamSum return this;
  private var self(get,never):GTypeParam;
  private function get_self():GTypeParam return lift(this);

  public function toSource():GSource{
		return Printer.ZERO.printTypeParam(this);
	}
}
class GTypeParamLift{
  #if macro
  static public function to_macro_at(self:GTypeParam,pos:Position):TypeParam{
    return switch(self){
      case GTPType( t ) : TPType(t.to_macro_at(pos));
	    case GTPExpr( e ) : TPExpr(e.to_macro_at(pos));
    }
  }
  #end
}