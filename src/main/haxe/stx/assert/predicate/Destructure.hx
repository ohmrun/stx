package stx.assert.predicate;

import stx.assert.predicate.term.*;

class Destructure extends Clazz{
  /**
    Produces a predicate that succeeds if both succeed.
  **/
  public function and<T,E>(p2: Predicate<T,E>,p1: Predicate<T,E>): Predicate<T,E> {
    return new And(p1,p2);
  }

  /**
    Produces a predicate that succeeds if one or other predicates succeed.
  **/
  public function or<T,E>(p2: Predicate<T,E>,p1: Predicate<T,E>): Predicate<T,E> {
    return new Or(p1,p2);
  }
  /**
    Produces a predicate that succeeds if one or other , but not both predicates succeed.
  **/
  public function xor<T,E>(p2: Predicate<T,E>, p1: Predicate<T,E>): Predicate<T,E> {
    return new XOr(p1,p2);
  }
  /**
    Produces a predicate that succeeds if the input predicate fails.
  **/
  public function not<T,E>(p: Predicate<T,E>):Predicate<T,E>{
    return new Not(p);
  }

  public function errata<T,E,EE>(fn:Refuse<E>->Refuse<EE>,p: Predicate<T,E>):Predicate<T,EE>{
    return new Transform(p,fn);
  }
}