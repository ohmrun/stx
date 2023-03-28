package stx.assert;

// TODO stx_release fix
import stx.fail.Refuse;

import stx.assert.predicate.term.*;

interface PredicateApi<P,E>{
  public function apply(p:P):Report<E>;
}

@:using(stx.assert.Predicate.PredicateLift)
@:forward abstract Predicate<T,E>(PredicateApi<T,E>) from PredicateApi<T,E> to PredicateApi<T,E>{
  static public var _(default,null) = PredicateLift;

  public function new(v:PredicateApi<T,E>) this = v;

  
  @:noUsing static public function Natural<T>(method:T->Bool,?pos:Pos):Predicate<T,AssertFailure>{
    return new Natural(method,pos);
  }
  @:noUsing static public function NaturalReport<T,E>(method:T->Bool,e:E,?pos:Pos):Predicate<T,E>{
    return new NaturalReport(method,e,pos);
  }
  @:noUsing static public function Anon<T,E>(method:T->Report<E>):Predicate<T,E>{
    return new stx.assert.predicate.term.Anon(method);
  }
  @:noUsing static public function unit<T,E>():Predicate<T,E> return new Always();


  @:noUsing static public function always<T>(?pos:Pos):Predicate<T,AssertFailure>{
    return new Always();
  }
  @:noUsing static public function never<T,E>(?pos:Pos):Predicate<T,E>{
    return new stx.assert.predicate.term.Never(pos);
  }
  @:noUsing static public inline function iz(?pos:Pos,clazz:Class<Dynamic>):Predicate<Dynamic,AssertFailure>{
    return new Is(clazz,pos);
  }
  @:noUsing static public inline function throws<E>(?pos:Pos):Predicate<Block,AssertFailure>{
    return new Throws(pos);
  }
  @:noUsing static public inline function void<T>(?pos:Pos):Predicate<T,AssertFailure>{
    return new stx.assert.predicate.term.Void(pos);
  }
  @:noUsing static public inline function exists<T>(?pos:Pos):Predicate<T,AssertFailure>{
    return new Exists(pos);
  }
  @:noUsing static public inline function matches<E>(?pos:Pos,reg:String,opt:String):Predicate<String,AssertFailure>{
    return new Matches(pos,reg,opt);
  }
  public inline function ordef(l:T,r:T):T{
    return this.apply(l).is_defined() ? r : l;
  }
  public inline function fudge(v:T):T{
    return this.apply(v).fold(
      (x) -> throw x,
      () -> v
    );
  }
  public inline function bindI(v){
    return this.apply.bind(v);
  }
  public function check():T->Bool{
    return (x) -> this.apply(x) == None;
  }
  inline public function crunch(v:T){
    this.apply(v).fold(
      __.crack,
      () -> {}
    );
  }
}
class PredicateLift{

  /**
   * Produces a predicate that succeeds if all input predicates succeed.
  **/
  static public function ands<T,E>(self: Predicate<T,E>,rest: Iterable<Predicate<T,E>>): Predicate<T,E> {
    return rest.fold(
      (next,memo) -> new And(memo,next),
      self
    );
  }
  /**
   * Produces a predicate that succeeds if any of the input predicates succeeds.
  **/
  static public function ors<T,E>(self: Predicate<T,E>,rest: Iterable<Predicate<T,E>>): Predicate<T,E > {
    return rest.fold(
      (next,memo) -> new Or(memo,next),
      self
    );
  }
  /**
    Produces a predicate that succeeds if both succeed.
  **/
  static public function and<T,E>(self: Predicate<T,E>,that: Predicate<T,E>): Predicate<T,E> {
    return new And(self,that);
  }

  /**
    Produces a predicate that succeeds if one or other predicates succeed.
  **/
  static public function or<T,E>(self: Predicate<T,E>,that: Predicate<T,E>): Predicate<T,E> {
    return new Or(self,that);
  }
  /**
    Produces a predicate that succeeds if one or other , but not both predicates succeed.
  **/
  static public function xor<T,E>(self: Predicate<T,E>, that: Predicate<T,E>): Predicate<T,E> {
    return new XOr(self,that);
  }
  /**
    Produces a predicate that succeeds if the input predicate fails.
  **/
  static public function not<T,E>(self: Predicate<T,E>):Predicate<T,E>{
    return new Not(self);
  }

  static public function errata<T,E,EE>(self: Predicate<T,E>,fn:Refuse<E>->Refuse<EE>):Predicate<T,EE>{
    return new Transform(self,fn);
  }
  static public function errate<T,E,EE>(self:Predicate<T,E>,fn:E->EE):Predicate<T,EE>{
    return errata(self,(err) -> err.errate(fn));
  }
  static public function map_i<T,Ti,E>(self:Predicate<T,E>,fn:Ti->T):Predicate<Ti,E>{
    return Predicate.Anon(
      (v:Ti) -> self.apply(fn(v)) 
    );
  }
}