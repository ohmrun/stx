package stx.g.lang.expr;

class GFieldTypeCtr extends Clazz{
  static public function unit(){
    return new GFieldTypeCtr();
  }
  private function lift(self:GFieldTypeSum):GFieldType{
    return GFieldType.lift(self);
  }
  public function Var(?t:CTR<GComplexTypeCtr,GComplexType>, ?e:CTR<GExprCtr,GExpr>){
    return lift(
      GFVar(
        __.option(t).map(f -> f(GComplexTypeCtr.unit())).defv(null),
        __.option(e).map(f -> f(GExprCtr.unit())).defv(null)
      )
    );
  }
  public function Fun(f:CTR<GFunctionCtr,GFunction>){
    return lift(GFFun(f(GFunctionCtr.unit())));
  }
  public function Prop(get:CTR<GPropAccessCtr,GPropAccess>,set:CTR<GPropAccessCtr,GPropAccess>,?t:CTR<GComplexTypeCtr,GComplexType>,?e:CTR<GExprCtr,GExpr>){
    return lift(GFProp(get(GPropAccess.__),set(GPropAccess.__),
      __.option(t).map(f -> f(GComplexType.__)).defv(null),
      __.option(e).map(f -> f(GExpr.__)).defv(null)
    ));
  }
}
enum GFieldTypeSum {
	GFVar( t  : Null<GComplexType>, ?e : Null<GExpr> );
	GFFun( f : GFunction );
	GFProp( get : GPropAccess, set : GPropAccess, ?t : Null<GComplexType>, ?e : Null<GExpr> );
}
@:using(stx.g.lang.expr.GFieldType.GFieldTypeLift)
abstract GFieldType(GFieldTypeSum) from GFieldTypeSum to GFieldTypeSum{
  static public var __(default,never) = new GFieldTypeCtr();
  public function new(self) this = self;
  @:noUsing static public function lift(self:GFieldTypeSum):GFieldType return new GFieldType(self);

  public function prj():GFieldTypeSum return this;
  private var self(get,never):GFieldType;
  private function get_self():GFieldType return lift(this);

  // public function toSource():GSource{
	// 	return Printer.ZERO.printFieldType(this);
	// }
}
class GFieldTypeLift{
  static public function to_macro_at(self:GFieldType,pos:Position){
    return switch(self){
      case GFVar( t  , e)            :  FVar(__.option(t).map(ct -> ct.to_macro_at(pos)).defv(null)  , __.option(e).map(e -> e.to_macro_at(pos)).defv(null));
      case GFFun( f  )               :  FFun( GFunction._.to_macro_at(f,pos)  );
      case GFProp( get , set , t, e) :  FProp( 
        get.getting() , 
        set.setting() , 
        __.option(t).map(x -> x.to_macro_at(pos)).defv(null) , 
        __.option(e).map(x -> x.to_macro_at(pos)).defv(null)
      );
    } 
  }
}