package stx.assert.module;

import stx.assert.Predicate.PredicateLift;

class Expect extends Clazz{
  var pos   : Pos;
  public function new(pos){
    super();
    this.pos = pos;
  }
  public function equals<T>():Assertion<T,AssertFailure>                                                return Assertion.equals(pos);
  public function alike<E>():Assertion<StdEnumValue,AssertFailure>                                      return Assertion.alike(pos);
  public function gt<T>():Assertion<T,AssertFailure>                                                    return Assertion.gt(pos);
  public function gt_eq<T>():Assertion<T,AssertFailure>                                                 return Assertion.gt_eq(pos);
  public function lt<T>():Assertion<T,AssertFailure>                                                    return Assertion.lt(pos);
  public function lt_eq<T>():Assertion<T,AssertFailure>                                                 return Assertion.lt_eq(pos);

  public function always<T>():Predicate<T,AssertFailure>                                                return Predicate.always(pos);
  public function never<T,E>():Predicate<T,E>                                                           return Predicate.never(pos);
  public function iz(clazz:Class<Dynamic>):Predicate<Dynamic,AssertFailure>                             return Predicate.iz(pos,clazz);
  public function throws<E>():Predicate<Block,AssertFailure>                                            return Predicate.throws(pos);
  public function void<T>():Predicate<T,AssertFailure>                                                  return Predicate.void(pos);
  public function exists<T>():Predicate<T,AssertFailure>                                                return Predicate.exists(pos);
  public function matches<E>(reg:String,opt:String):Predicate<String,AssertFailure>                     return Predicate.matches(pos,reg,opt);

  public inline function ands<T,E>(self: Predicate<T,E>,rest: Iterable<Predicate<T,E>>): Predicate<T,E> return PredicateLift.ands(self,rest);
  public inline function ors<T,E>(self: Predicate<T,E>,rest: Iterable<Predicate<T,E>>): Predicate<T,E > return PredicateLift.ors(self,rest);
  public inline function and<T,E>(self: Predicate<T,E>,that: Predicate<T,E>): Predicate<T,E>            return PredicateLift.and(self,that);
  public inline function or<T,E>(self: Predicate<T,E>,that: Predicate<T,E>): Predicate<T,E>             return PredicateLift.or(self,that);
  public inline function xor<T,E>(self: Predicate<T,E>, that: Predicate<T,E>): Predicate<T,E>           return PredicateLift.xor(self,that);
  public inline function not<T,E>(self: Predicate<T,E>):Predicate<T,E>                                  return PredicateLift.not(self);
}