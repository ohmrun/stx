package stx.makro.expr;

final Expr = __.makro().expr;
/**
 * Constructor Class for HFieldType;
 */
class HFieldTypeCtr extends Clazz{
  public function FVar( t : Null<stx.makro.expr.HComplexType>, ?e : Null<stx.makro.expr.HExpr> ){
    return HFieldType.lift(StdFieldType.FVar(__.option(t).map((t:stx.makro.expr.HComplexType) -> t.prj()).defv(null),__.option(e).map(e -> e.prj()).defv(null)));
  }
	public function FFun( f : stx.makro.expr.HFunction ){
    return HFieldType.lift(StdFieldType.FFun(f.prj()));
  }
	public function FProp( ?get : CTR<HPropAccessCtr,HPropAccess>, ?set : CTR<HPropAccessCtr,HPropAccess>, ?t : Null<stx.makro.expr.HComplexType>, ?e : Null<stx.makro.expr.HExpr> ){
    return HFieldType.lift(
      StdFieldType.FProp(
        get.apply(Expr.HPropAccess),
        set.apply(Expr.HPropAccess),
        __.option(t).map((t:stx.makro.expr.HComplexType) -> t.prj()).defv(null),
        __.option(e).map(e -> e.prj()).defv(null)
      )
    );
  }
}
typedef HFieldTypeDef = StdFieldType;

@:using(stx.makro.expr.HFieldType.HFieldTypeLift)
@:forward abstract HFieldType(StdFieldType) from StdFieldType to StdFieldType{
  static public var _(default,never) = HFieldTypeLift;
  public inline function new(self:StdFieldType) this = self;
  static inline public function lift(self:StdFieldType):HFieldType return new HFieldType(self);

  public function prj():StdFieldType return this;
  private var self(get,never):HFieldType;
  private function get_self():HFieldType return lift(this);

}
class HFieldTypeLift{
  static public inline function lift(self:StdFieldType):HFieldType{
    return HFieldType.lift(self);
  }
}