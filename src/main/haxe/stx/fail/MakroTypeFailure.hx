package stx.fail;

enum MakroTypeFailureSum{
  E_MakroType_TDynamicNull;
  E_MakroType_UnexpectedMono;
  E_MakroType_UnexpectedEnum;
  E_MakroType_UnexpectedTDef(x:haxe.macro.Type.DefType);
  E_MakroType_UnexpectedTFun;
  E_MakroType_DynamicUnsupported;
  E_MakroType_UnexpectedLazy;
  /**
   * If I can't nudge the compiler into resolving a monomorph.
   */
  E_MakroType_UnresolvedMonomorph;
}
abstract MakroTypeFailure(MakroTypeFailureSum) from MakroTypeFailureSum to MakroTypeFailureSum{
  public function new(self) this = self;
  @:noUsing static public function lift(self:MakroTypeFailureSum):MakroTypeFailure return new MakroTypeFailure(self);

  public function prj():MakroTypeFailureSum return this;
  private var self(get,never):MakroTypeFailure;
  private function get_self():MakroTypeFailure return lift(this);
}
