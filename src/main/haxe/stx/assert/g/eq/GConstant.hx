package stx.assert.g.eq;

import stx.g.lang.expr.GConstant as GConstantT;

class GConstant implements EqApi<GConstantT> extends Clazz{
  public function comply(lhs:GConstantT,rhs:GConstantT){
    return switch([lhs,rhs]){
      case [GCInt(vI, sI),GCInt(vII, sII)]      :
        var eq = Eq.String().comply(vI,vII);
        if(eq.is_ok()){
          eq = Eq.NullOr(Eq.String()).comply(sI,sII);
        }
        eq;
      case [GCFloat(fI, sI),GCFloat(fII, sII)]  :
        var eq = Eq.String().comply(fI,fII);
        if(eq.is_ok()){
          eq = Eq.NullOr(Eq.String()).comply(sI,sII);
        }
        eq;
      case [GCString(sI, kindLiteralKindI),GCString(sII, kindLiteralKindII)]:
        var eq = Eq.String().comply(sI,sII);
        if(eq.is_ok()){
          eq = new GStringLiteralKind().comply(kindLiteralKindI,kindLiteralKindII);
        }
        eq;
      case [GCIdent(sI) ,GCIdent(sII) ]:
        Eq.String().comply(sI,sII);
      case [GCRegexp(rI, optI),GCRegexp(rII, optII)]:
        var eq = Eq.String().comply(rI,rII);
        if(eq.is_ok()){
          //final f = RedBlackSet.String()
          eq = Eq.String().comply(optI,optII);//TODO this is actually a set, I think
        }
        eq;
      default : Eq.EnumValueIndex().comply(lhs,rhs);
    }
  }
}