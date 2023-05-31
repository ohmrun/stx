package stx.assert.makro.expr.eq;

import haxe.macro.Expr.Constant;
import stx.makro.expr.HConstant as THConstant;

final Eq = __.assert().Eq();

class HConstant extends EqCls<THConstant>{

  public function new(){}

  public function comply(a:THConstant,b:THConstant):Equaled{
    final seq   = Eq.String();
    final nseq  = Eq.NullOr(seq);

    return switch([a,b]){
      case [CInt(vI, sI),CInt(vII, sII)]                : 
        var eq = seq.comply(vI,vII);
        if(eq.are_not_equal()){
          eq = nseq.comply(vI,vII);
        }
        eq;
	    case [CFloat(fI, sI),CFloat(fII, sII)]            :  
        var eq = seq.comply(fI,fII);
        if(eq.are_not_equal()){
          eq = nseq.comply(sI,sII);
        }
        eq;
	    case [CString(sI, kindI),CString(sII, kindII)]  :
        var eq = seq.comply(sI,sII);
        if(eq.are_not_equal()){
          Eq.Makro().Expr().StringLiteralKind.comply(kindI,kindII);
        }
        eq;
	    case [CIdent(sI),CIdent(sII)]                   : 
        seq.comply(sI,sII);
	    case [CRegexp(rI, optI),CRegexp(rII, optII)]    : 
        var eq = seq.comply(rI,rII);
        if(eq.are_not_equal()){
          eq = seq.comply(optI,optII);
        }
        eq;
      default : NotEqual;
    };
  }
}