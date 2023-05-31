package stx.makro.type;

@:using(stx.makro.type.HAbstractType)
@:forward abstract HAbstractType(AbstractType) from AbstractType to AbstractType{
  static public var _(default,never) = HAbstractTypeLift;
  public function new(self) this = self;
  @:noUsing static public function lift(self:AbstractType):HAbstractType return new HAbstractType(self);

  public function prj():AbstractType return this;
  private var self(get,never):HAbstractType;
  private function get_self():HAbstractType return lift(this);
}
class HAbstractTypeLift{
  
}