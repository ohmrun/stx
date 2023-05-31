package stx.makro.pack;

import haxe.macro.Context;
import stx.makro.Expr;


class Api{
  public function new(){}
  public function ref(name,pos){
    return stx.makro.HExpr.ref(name,pos);
  }
  public function def(){
    return new ApiHExprdef();
  }
  public function const(){
    return new ApiConst();
  }
  public function lits(){
    return new ApiLiterals();
  }
}
class ApiHExprdef{
  public function new(){}
  private function lift(self){
    return HExprdef.lift(self);
  }
  public function econst(v:StdConstant):HExprdef{
    return lift(EConst(v));
  }
  public function ecall(self,with):HExprdef{
    return lift(ECall(self,with));
  }
  public function eswitch(e,cases,def):HExprdef{
    return lift(ESwitch(e,cases,def));
  }
  public function earraydecl(vals:Array<StdExpr>):HExprdef{
    return lift(EArrayDecl(vals));
  }
  public function ebinop(op,l,r):HExprdef{
    return lift(EBinop(op,l,r));
  }
  public function efield(e,f):HExprdef{
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