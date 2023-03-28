package stx.makro.def;

@:using(stx.makro.def.HField.HFieldLift)
@:forward abstract HField(StdField) from StdField to StdField{
  static public var _(default,never) = HFieldLift;
  public inline function new(self:StdField) this = self;
  static inline public function lift(self:StdField):HField return new HField(self);

  static inline public function make(name:String,kind:HFieldType,pos:Position,?access,?doc,?meta){
    return lift({
      name      : name,
      kind      : kind,
      pos       : pos,
      access    : access,
      doc       : doc,
      meta      : meta
    });
  }
  public function prj():StdField return this;
  private var self(get,never):HField;
  private function get_self():HField return lift(this);

}
class HFieldLift{
  static public inline function lift(self:StdField):HField{
    return HField.lift(self);
  }
}