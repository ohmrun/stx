package stx.assert;

import stx.pico.Couple as StdCouple;


import stx.assert.eq.term.Primitive; 
import stx.assert.eq.term.Nada; 
import stx.assert.eq.term.Anon;
import stx.assert.eq.term.*;
import stx.assert.eq.term.Couple;
import stx.assert.eq.term.KV;
import stx.assert.eq.term.Int;
import stx.assert.eq.term.Int64;
import stx.assert.eq.term.String;
import stx.assert.eq.term.Cluster;
import stx.assert.eq.term.EnumValueIndex;
import stx.assert.eq.term.NullOr;

/**
 * Equality function Api
 */
interface EqApi<T>{
  public function comply(lhs:T,rhs:T):Equaled;
  public function toEqApi():EqApi<T>;
}
/**
 * Equality function Api
 * abstract class for `T -> T -> Equaled`
 */
abstract class EqCls<T> implements EqApi<T>{
  abstract public function comply(lhs:T,rhs:T):Equaled;
  public function toEqApi():EqApi<T>{
    return this;
  }
}
/**
 * Constructors for `Eq`
 */
class EqCtr extends Clazz{

}
/**
 * Abstract for equality function Api
 * Individual constructors at `__.assert().Eq()`.
 */
@:forward abstract Eq<T>(EqApi<T>) from EqApi<T> to EqApi<T>{
  static public var __(default,never) = new EqCtr();
  public inline function new(self){
    this = self;
  }
  @:noUsing static public inline function lift<T>(self:EqApi<T>){
    return new Eq(self);
  }
  @:from static public function fromAnon<T>(fn : (lhs : T, rhs : T) -> stx.assert.Equaled):Eq<T>{
    return Anon(fn);
  }
  public function toAssertion(?pos:Pos):Assertion<T,AssertFailure>{
    return new EqAssertion(this,pos);
  } 
  @:noUsing static public function Int():Eq<StdInt>{
    return new Int();
  }
  @:noUsing static public function Int64():Eq<haxe.Int64>{
    return new Int64();
  }
  @:noUsing static public function String():Eq<std.String>{
    return new String();
  }
  @:noUsing static public function Couple<L,R>(l:Eq<L>,r:Eq<R>):Eq<StdCouple<L,R>>{
    return new Couple(l,r);
  }
  @:noUsing static public function KV<L,R>(l:Eq<L>,r:Eq<R>):Eq<stx.nano.KV<L,R>>{
    return new KV(l,r);
  }
  @:noUsing static public function Anon<T>(fn:T->T->Equaled):Eq<T>{
    return new Anon(fn);
  }
  @:noUsing static public function Nada():Eq<stx.pico.Nada>{
    return new Eq(new Nada());
  }
  @:noUsing static public function Bool():Eq<StdBool>{
    return Anon(
      (l,r) -> l == r ? AreEqual : NotEqual
    );
  }
  @:noUsing static public function Float():Eq<StdFloat>{
    return Anon(
      (l,r) -> l == r ? AreEqual : NotEqual
    );
  }
  @:noUsing static public function ArrayEq<T>(inner:Eq<T>):Eq<StdArray<T>>{
    return new ArrayEq(inner);
  }
  @:noUsing static public function Record<T>(inner:Eq<T>):Eq<stx.Record<T>>{
    return new stx.assert.eq.term.Record(inner);
  }
  @:noUsing static public function Cluster<T>(inner:Eq<T>):Eq<stx.nano.Cluster<T>>{
    return new Cluster(inner);
  }
  @:noUsing static public function Primitive():Eq<stx.nano.Primitive>{
    return new Primitive();
  }
  @:noUsing static public function Option<T>(inner:Eq<T>):Eq<Option<T>>{
    return new stx.assert.eq.term.Option(inner);
  }
  @:noUsing static public function EnumValueIndex():Eq<StdEnumValue>{
    return new EnumValueIndex();
  }
  @:noUsing static public function NullOr<T>(inner:Eq<T>):Eq<Null<T>>{
    return new stx.assert.eq.term.NullOr(inner);
  }
  @:noUsing static public function Ident():Eq<Ident>{
    return new stx.assert.eq.term.Ident();
  }
  @:noUsing static public function Register():Eq<Register>{
    return new stx.assert.eq.term.Register();
  }
  @:noUsing static public function Tup2<L,R>(l:Eq<L>,r:Eq<R>):Eq<Tup2<L,R>>{
    return new stx.assert.eq.term.Tup2(l,r);
  }
  @:noUsing static public function StringMap<T>(inner:Eq<T>):Eq<haxe.ds.StringMap<T>>{
    return new stx.assert.eq.term.StringMap(inner);
  }
  @:noUsing static public function Map<K,V>(val:Eq<V>):Eq<haxe.ds.Map<K,V>>{
    return new stx.assert.eq.term.Map(val);
  }
}

