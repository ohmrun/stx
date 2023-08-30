package stx.makro.expr.typed;

/*
  enum TConstant {
    TInt(i:Int);
    TFloat(s:String);
    TString(s:String);
    TBool(b:Bool);
    TNull;
    TThis;
    TSuper;
}
*/
class HTConstantCtr extends Clazz{
  // public function Int(v:String,?s:String){
  //   return HTConstant.lift(CInt(v,s));
  // }
  // public function Float(v:String,?s:String){
  //   return HTConstant.lift(CFloat(v,s));
  // }
  // public function String(v:String,?s:HStringLiteralKind){
  //   return HTConstant.lift(CString(v,s));
  // }
  // public function Ident(v:String){
  //   return HTConstant.lift(CIdent(v));
  // }
  // public function Regexp(v:String,opt:String){
  //   return HTConstant.lift(CRegexp(v,opt));
  // }
}
typedef HTConstantDef = haxe.macro.Type.TConstant;

@:using(stx.makro.expr.typed.HTConstant.HTConstantLift)
@:forward abstract HTConstant(HTConstantDef) from HTConstantDef to HTConstantDef{
  static public var _(default,never) = HTConstantLift;
  public function new(self) this = self;
  @:noUsing static public function lift(self:HTConstantDef) return new HTConstant(self);

  public function prj(){
    return this;
  }
}
class HTConstantLift{
  
}