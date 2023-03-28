package stx.assert;

/**
  https://github.com/typelevel/cats/blob/main/kernel/src/main/scala/cats/kernel/PartialOrder.scala
**/

typedef PartialOrderedDef = Null<Float>;

abstract PartialOrdered(PartialOrderedDef) from PartialOrderedDef {
  public function new(self) this = self;
  @:noUsing static public function lift(self:PartialOrderedDef):PartialOrdered return new PartialOrdered(self);

  @:noUsing static public function unorderable():PartialOrdered{
    return lift(null);
  } 
  public function prj():PartialOrderedDef return this;
  private var self(get,never):PartialOrdered;
  private function get_self():PartialOrdered return lift(this);
}

interface PartialOrdApi<T>{
  public function comply(lhs:T,rhs:T):PartialOrdered;
}
interface PartialOrderableApi<T>{
  public function lt():PartialOrdApi<T>;
}
interface PartialComparableApi<T> extends EqualableApi<T> extends PartialOrderableApi<T>{

}