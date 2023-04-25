package stx.assert.predicate;

import stx.assert.predicate.term.*;

class Base extends Clazz{
  static public var ZERO(default,never) = new Base();

  public function always<T>(?pos:Pos):Predicate<T,AssertFailure>{
    return new Always();
  }
  public function never<T,E>(?pos:Pos):Predicate<T,E>{
    return new stx.assert.predicate.term.Never(pos);
  }
  public inline function is<A>(?pos:Pos,clazz:Class<A>):Predicate<A,AssertFailure>{
    return new Is(clazz,pos);
  }
  public inline function throws<E>(?pos:Pos):Predicate<Block,AssertFailure>{
    return new Throws(pos);
  }
  public inline function void<T>(?pos:Pos):Predicate<T,AssertFailure>{
    return new stx.assert.predicate.term.Void(pos);
  }
  public inline function exists<T>(?pos:Pos):Predicate<T,AssertFailure>{
    return new Exists(pos);
  }
  public inline function matches<E>(?pos:Pos,reg:String,opt:String):Predicate<String,AssertFailure>{
    return new Matches(pos,reg,opt);
  }
}