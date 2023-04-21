package stx.g.lang;

abstract GSource(String) from String to String{
  public function new(self) this = self;
  @:noUsing static public function lift(self:String):GSource return new GSource(self);

  public function prj():String  return this;
  private var self(get,never):GSource;
  private function get_self():GSource return lift(this);
}