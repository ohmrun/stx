package eu.ohmrun.pml;

enum PChainKindSum{
  @eu.ohmrun.pml.spec(":pspec/array")
  PCArray;
  @eu.ohmrun.pml.spec(":pspec/group")
  PCGroup;
  @eu.ohmrun.pml.spec(":pspec/set")
  PCSet;
}

@:using(eu.ohmrun.pml.PChainKind.PChainKindLift)
abstract PChainKind(PChainKindSum) from PChainKindSum to PChainKindSum{
  
  public inline function new(self:PChainKindSum) this = self;
  @:noUsing static inline public function lift(self:PChainKindSum):PChainKind return new PChainKind(self);

  public function prj():PChainKindSum return this;
  private var self(get,never):PChainKind;
  private function get_self():PChainKind return lift(this);
}
class PChainKindLift{
  static public inline function lift(self:PChainKindSum):PChainKind{
    return PChainKind.lift(self);
  }
}