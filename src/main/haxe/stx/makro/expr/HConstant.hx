package stx.makro.expr;

@:using(stx.makro.expr.HConstant.HConstantLift)
abstract HConstant(StdConstant) from StdConstant to StdConstant{
  static public var _(default,never) = HConstantLift;
  public function new(self) this = self;
  @:noUsing static public function lift(self:StdConstant) return new HConstant(self);

  @:noUsing static public function CString(str:String):HConstant{
    return lift(StdConstant.CString(str));
  }
  @:noUsing static public function CIdent(str:String):HConstant{
    return lift(StdConstant.CIdent(str));
  }
  public function to_macro_at(pos:Position):HExpr{
    return HExpr.make(HExprDef.lift(EConst(prj())),pos);
  }
  public function prj(){
    return this;
  }
}
class HConstantLift{
  
}