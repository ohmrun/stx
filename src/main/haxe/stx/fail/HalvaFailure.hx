package stx.fail;

enum HalvaFailureSum{
  E_Halva_Top;
  E_Halva_Frozen;
  E_Halva_Malformed;
}
abstract HalvaFailure(HalvaFailureSum) from HalvaFailureSum to HalvaFailureSum{
  public function new(self) this = self;
  @:noUsing static public function lift(self:HalvaFailureSum):HalvaFailure return new HalvaFailure(self);

  public function prj():HalvaFailureSum return this;
  private var self(get,never):HalvaFailure;
  private function get_self():HalvaFailure return lift(this);
}

