package stx.assert.glot.ord;

#if (haxe_ver > 4.205)
import eu.ohmrun.glot.expr.GEFieldKind as GEFieldKindT;

class GEFieldKind extends OrdCls<GEFieldKindT>{
  public function new(){}
  public function comply(lhs:GEFieldKindT,rhs:GEFieldKindT){
    return Ord.EnumValueIndex().comply(lhs,rhs);
  }
}
#end