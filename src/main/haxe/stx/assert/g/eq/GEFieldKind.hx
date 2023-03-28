package stx.assert.g.eq;

#if (haxe_ver > 4.205)
import stx.g.lang.expr.GEFieldKind as GEFieldKindT;

class GEFieldKind implements EqApi<GEFieldKindT> extends Clazz{
  public function comply(lhs:GEFieldKindT,rhs:GEFieldKindT){
    return Eq.EnumValueIndex().comply(lhs,rhs);
  }
}
#end