package eu.ohmrun.glot.expr;

final Expr = __.glot().Expr;

class GFieldTypeCtr extends Clazz{
  public function Var(?t:CTR<GComplexTypeCtr,GComplexType>, ?e:CTR<GExprCtr,GExpr>){
    return GFieldType.lift(
      GFVar(
        __.option(t).map(f -> f(Expr.GComplexType)).defv(null),
        __.option(e).map(f -> f(Expr.GExpr)).defv(null)
      )
    );
  }
  public function Fun(f:CTR<GFunctionCtr,GFunction>){
    return GFieldType.lift(GFFun(f(Expr.GFunction)));
  }
  public function Prop(get:CTR<GPropAccessCtr,GPropAccess>,set:CTR<GPropAccessCtr,GPropAccess>,?t:CTR<GComplexTypeCtr,GComplexType>,?e:CTR<GExprCtr,GExpr>){
    return GFieldType.lift(GFProp(get(Expr.GPropAccess),set(Expr.GPropAccess),
      __.option(t).map(f -> f(Expr.GComplexType)).defv(null),
      __.option(e).map(f -> f(Expr.GExpr)).defv(null)
    ));
  }
}
enum GFieldTypeSum {
	GFVar( t  : Null<GComplexType>, ?e : Null<GExpr> );
	GFFun( f : GFunction );
	GFProp( get : GPropAccess, set : GPropAccess, ?t : Null<GComplexType>, ?e : Null<GExpr> );
}
@:using(eu.ohmrun.glot.expr.GFieldType.GFieldTypeLift)
abstract GFieldType(GFieldTypeSum) from GFieldTypeSum to GFieldTypeSum{
    public function new(self) this = self;
  @:noUsing static public function lift(self:GFieldTypeSum):GFieldType return new GFieldType(self);

  public function prj():GFieldTypeSum return this;
  private var self(get,never):GFieldType;
  private function get_self():GFieldType return GFieldType.lift(this);

  // public function toSource():GSource{
	// 	return Printer.ZERO.printFieldType(this);
	// }
}
class GFieldTypeLift{
  #if macro
  static public function to_macro_at(self:GFieldType,pos:Position):FieldType{
    return switch(self){
      case GFieldTypeSum.GFVar( t  , e)            :  FVar(
        __.option(t).map(ct -> ct.to_macro_at(pos)).defv(null)  , 
        __.option(e).map(e -> e.to_macro_at(pos)).defv(null))
      ;
      case GFieldTypeSum.GFFun( f  )               :  FFun( GFunction._.to_macro_at(f,pos)  );
      case GFieldTypeSum.GFProp( get , set , t, e) :  FProp( 
        get.getting() , 
        set.setting() , 
        __.option(t).map(x -> x.to_macro_at(pos)).defv(null) , 
        __.option(e).map(x -> x.to_macro_at(pos)).defv(null)
      );
    } 
  }
  #end
}