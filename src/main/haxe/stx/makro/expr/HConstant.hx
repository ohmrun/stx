package stx.makro.expr;


class HConstantCtr extends Clazz{
  public function Int(v:String,?s:String){
    return HConstant.lift(CInt(v,s));
  }
  public function Float(v:String,?s:String){
    return HConstant.lift(CFloat(v,s));
  }
  public function String(v:String,?s:HStringLiteralKind){
    return HConstant.lift(CString(v,s));
  }
  public function Ident(v:String){
    return HConstant.lift(CIdent(v));
  }
  public function Regexp(v:String,opt:String){
    return HConstant.lift(CRegexp(v,opt));
  }
}
typedef HConstantDef = StdConstant;
@:using(stx.makro.expr.HConstant.HConstantLift)
@:forward abstract HConstant(StdConstant) from StdConstant to StdConstant{
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
    return HExpr.make(HExprdef.lift(EConst(prj())),pos);
  }
  public function prj(){
    return this;
  }
}
class HConstantLift{
  
}