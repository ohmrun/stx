package eu.ohmrun.pml.term.spine;

import stx.om.spine.Spine in TSpine;
import stx.om.spine.Spine.SpineSum in TSpineSum;

typedef PmlSpineDef = TSpineSum<Tup2<PmlSpine,PmlSpine>>;

@:using(stx.om.spine.Spine.SpineLift)
@:using(eu.ohmrun.pml.term.spine.PmlSpine.PmlSpineLift)
@:transitive @:forward abstract PmlSpine(PmlSpineDef) from PmlSpineDef to PmlSpineDef to TSpine<Tup2<PmlSpine,PmlSpine>>{
  static public var _(default,never) = PmlSpineLift;
  public inline function new(self:PmlSpineDef) this = self;
  @:noUsing static inline public function lift(self:PmlSpineDef):PmlSpine return new PmlSpine(self);

  public function prj():PmlSpineDef return this;
  private var self(get,never):PmlSpine;
  private function get_self():PmlSpine return lift(this);
}
class PmlSpineLift{
  static public inline function lift(self:PmlSpineDef):PmlSpine{
    return PmlSpine.lift(self);
  }
  static public function toSpineNada(self:PmlSpine){
    return self.flat_map(
      tup -> Collect([tup.fst().toSpineNada,tup.snd().toSpineNada])
    );
  }
}