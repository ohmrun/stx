package stx.assert.glot.eq;

#if (haxe_ver > 4.205)
import eu.ohmrun.glot.expr.GEFieldKind as GEFieldKindT;

class GEFieldKind extends stx.assert.eq.term.Base<GEFieldKindT> {
  public function comply(lhs:GEFieldKindT,rhs:GEFieldKindT){
    return Eq.EnumValueIndex().comply(lhs,rhs);
  }
}
#end