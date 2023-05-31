package stx.om.spine.glot;

/**
 * The `Tup2<String,Array<GlotSpine>>` represents a dotted field name and it's arguments
 */
typedef GlotSpineDef = SpineSum<Tup2<String,Array<GlotSpine>>>;

@:using(stx.om.spine.Spine.SpineLift)
@:using(stx.om.spine.glot.GlotSpine.GlotSpineLift)
@:forward abstract GlotSpine(GlotSpineDef) from GlotSpineDef to GlotSpineDef to Spine<Tup2<String,Array<GlotSpine>>>{
  static public var _(default,never) = GlotSpineLift;
  public inline function new(self:GlotSpineDef) this = self;
  @:noUsing static inline public function lift(self:GlotSpineDef):GlotSpine return new GlotSpine(self);

  public function prj():GlotSpineDef return this;
  private var self(get,never):GlotSpine;
  private function get_self():GlotSpine return lift(this);
}
class GlotSpineLift{
  static public inline function lift(self:GlotSpineDef):GlotSpine{
    return GlotSpine.lift(self);
  }
  static public function toSpineNada(self:GlotSpine):Spine{
    return self.flat_map(
      (tp:Tup2<String,Array<GlotSpine>>) -> Collect([() -> Primate(PSprig(Textal(tp.fst())))].concat(tp.snd().map((x) -> () -> toSpineNada(x))))
    );
  }
}