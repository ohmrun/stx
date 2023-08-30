package stx.makro.type;

class HClassFieldCtr extends Clazz{

}
@:forward abstract HClassField(StdClassField) from StdClassField to StdClassField{
  public function new(self) this = self;
  @:noUsing static public function lift(self:StdClassField):HClassField return new HClassField(self);

  public function prj():StdClassField return this;
  private var self(get,never):HClassField;
  private function get_self():HClassField return lift(this);
}