package stx.fail;

enum ShowFailureSum{
  E_Show_DoesNotSupportLayout(c:stx.show.core.LayoutNode);
  E_Show_Escaped;
}
@:using(stx.fail.ShowFailure.ShowFailureLift)
abstract ShowFailure(ShowFailureSum) from ShowFailureSum to ShowFailureSum{
  static public var _(default,never) = ShowFailureLift;
  public inline function new(self:ShowFailureSum) this = self;
  @:noUsing static inline public function lift(self:ShowFailureSum):ShowFailure return new ShowFailure(self);

  public function prj():ShowFailureSum return this;
  private var self(get,never):ShowFailure;
  private function get_self():ShowFailure return lift(this);
}
class ShowFailureLift{
  static public inline function lift(self:ShowFailureSum):ShowFailure{
    return ShowFailure.lift(self);
  }
}
