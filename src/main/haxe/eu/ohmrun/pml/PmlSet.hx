package eu.ohmrun.pml;

typedef PmlSetDef<T> = Cluster<T>;

/**
 * Just marks as a set, doesn't enforce
 */
@:using(eu.ohmrun.pml.PmlSet.PmlSetLift)
@:forward abstract PmlSet<T>(PmlSetDef<T>) from PmlSetDef<T> to PmlSetDef<T>{
  
  public inline function new(self:PmlSetDef<T>) this = self;
  @:noUsing static inline public function lift<T>(self:PmlSetDef<T>):PmlSet<T> return new PmlSet(self);

  public function prj():PmlSetDef<T> return this;
  private var self(get,never):PmlSet<T>;
  private function get_self():PmlSet<T> return lift(this);
}
class PmlSetLift{
  static public inline function lift<T>(self:PmlSetDef<T>):PmlSet<T>{
    return PmlSet.lift(self);
  }
}