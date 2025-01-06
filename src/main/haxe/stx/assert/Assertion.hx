package stx.assert;

import stx.assert.assertion.term.*;

interface AssertionApi<P,E>{
  public function comply(lhs:P,rhs:P):Report<E>;
  public function asAssertionApi():AssertionApi<P,E>;
}

@:forward abstract Assertion<T,E>(AssertionApi<T,E>) from AssertionApi<T,E>{
  /**
   * Creates a Predicate from an Assertion.
   * @param l 
   * @return Predicate<T>
   */
  public function bindI(l:T):Predicate<T,E>{
    return new stx.assert.predicate.term.AssertionPredicate(this,l);
  }
  @:noUsing static public function equals<T>(?pos:Pos):Assertion<T,AssertFailure>{
    return new Equals(pos);
  }
  @:noUsing static public inline function alike<E>(?pos:Pos):Assertion<StdEnumValue,AssertFailure>{
    return new Alike(pos);
  }
  @:noUsing static public function gt<T>(?pos:Pos):Assertion<T,AssertFailure>{
    return new GreaterThan(pos);
  }
  @:noUsing static public inline function gt_eq<T>(?pos:Pos):Assertion<T,AssertFailure>{
    return new GreaterThanOrEquals(pos);
  }
  @:noUsing static public inline function lt<T>(?pos:Pos):Assertion<T,AssertFailure>{
    return new LessThan(pos);
  }
  @:noUsing static public inline function lt_eq<T>(?pos:Pos):Assertion<T,AssertFailure>{
    return new LessThanOrEquals(pos);
  }
  @:noUsing static public function Anon<P,E>(fn:P->P->Report<E>):Assertion<P,E>{
    return new Anon(fn);
  }
  @:noUsing static public function Errata<P,E,EE>(self:Assertion<P,E>,fn:E->EE):Assertion<P,EE>{
    return new stx.assert.assertion.term.Errata(self.asAssertionApi(),fn);
  }
}