package eu.ohmrun.pml;

enum PSpecSum<T>{
  @eu.ohmrun.pml.spec("#sig")
  PSig(sig:PSignature);
  @eu.ohmrun.pml.spec("#seq")
  PSeq(l:PSpec<T>,r:PSpec<T>);
  @eu.ohmrun.pml.spec("#alt")
  PAlt(l:PSpec<T>,r:PSpec<T>);
  @eu.ohmrun.pml.spec("#opt")
  POpt(spec:PSpec<T>);
  @eu.ohmrun.pml.spec("#not")
  PNot(spec:PSpec<T>);
  @eu.ohmrun.pml.spec("#any")
  PAny;
  @eu.ohmrun.pml.spec("#itm")
  PItm;//PLabel,PApply,PValue
  @eu.ohmrun.pml.spec("#lst")
  PLst;//PGroup,PArray,PSet
  @eu.ohmrun.pml.spec("#str")
  PStr;//PLabel,PApply
  @eu.ohmrun.pml.spec("#nil")
  PNil;//PEmpty
  @eu.ohmrun.pml.spec("#val")
  PVal(v:T);//PValue
}
@:using(eu.ohmrun.pml.PSpec.PSpecLift)
abstract PSpec<T>(PSpecSum<T>) from PSpecSum<T> to PSpecSum<T>{
  
  public inline function new(self:PSpecSum<T>) this = self;
  @:noUsing static inline public function lift<T>(self:PSpecSum<T>):PSpec<T> return new PSpec(self);

  public function prj():PSpecSum<T> return this;
  private var self(get,never):PSpec<T>;
  private function get_self():PSpec<T> return lift(this);
}
class PSpecLift{
  static public inline function lift<T>(self:PSpecSum<T>):PSpec<T>{
    return PSpec.lift(self);
  }
} 