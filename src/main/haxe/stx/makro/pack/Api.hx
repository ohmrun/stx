package stx.makro.pack;

import haxe.macro.Context;
import stx.makro.Expr;


class Api{
  public function new(){}
  public function ref(name,pos){
    return stx.makro.HExpr.ref(name,pos);
  }
  public function def(){
    return new ApiHExprDef();
  }
  public function const(){
    return new ApiConst();
  }
  public function lits(){
    return new ApiLiterals();
  }
}
class ApiHExprDef{
  public function new(){}
  private function lift(self){
    return HExprDef.lift(self);
  }
  public function econst(v:StdConstant):HExprDef{
    return lift(EConst(v));
  }
  public function ecall(self,with):HExprDef{
    return lift(ECall(self,with));
  }
  public function eswitch(e,cases,def):HExprDef{
    return lift(ESwitch(e,cases,def));
  }
  public function earraydecl(vals:Array<StdExpr>):HExprDef{
    return lift(EArrayDecl(vals));
  }
  public function ebinop(op,l,r):HExprDef{
    return lift(EBinop(op,l,r));
  }
  public function efield(e,f):HExprDef{
    return lift(EField(e,f));
  }
}
class ApiBinop{
  public function new(){}
  public function booland(){
    return OpBoolAnd;
  }
}
class ApiConst{
  public function new(){}
  public function string(str:String):Constant{
    return CString(str);
  }
  public function ident(str:String):Constant{
    return CIdent(str);
  }
}
class ApiLiterals{
  public function new(){}
  public function bool(b:Bool,pos):HExpr{
    return HConstant.lift(new ApiConst().ident(b ? 'true' : 'false')).to_macro_at(pos);
  }
}