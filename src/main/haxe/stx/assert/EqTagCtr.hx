package stx.assert;

import stx.nano.Couple as StdCouple;

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

private typedef TAG = STX<Eq<Dynamic>>;

class EqTagCtr{
  /**
   * `std.Int` instance for `stx.assert.Eq`
   * @param tag 
   * @return Eq<StdInt>
   */
  static public function Int(tag:TAG):Eq<StdInt>{
    return new Int();
  }
  /**
   * `haxe.Int64` instance for `stx.assert.Eq`
   * @param tag 
   * @return Eq<haxe.Int64>
   */
  static public function Int64(tag:TAG):Eq<haxe.Int64>{
    return new Int64();
  }
  /**
   * `std.String` instance for `stx.assert.Eq`
   * @param tag 
   * @return Eq<String>
   */
  static public function String(tag:TAG):Eq<StdString>{
    return new String();
  }
  /**
   * `stx.nano.Couple` instance for `stx.assert.Eq`
   * @param tag 
   * @param l
   * @param r
   * @return Eq<Couple<L,R>>
   */
  static public function Couple<L,R>(tag:TAG,l:Eq<L>,r:Eq<R>):Eq<StdCouple<L,R>>{
    return new Couple(l,r);
  }
  /**
   * `stx.nano.KV` instance for `stx.assert.Eq`
   * @param tag 
   * @param l
   * @param r
   * @return Eq<KV<L,R>>
   */
  static public function KV<L,R>(tag:TAG,l:Eq<L>,r:Eq<R>):Eq<stx.nano.KV<L,R>>{
    return new KV(l,r);
  }
  /**
   * lambda instance for `stx.assert.Eq`
   * @param fn
   * @param tag 
   * @param inner 
   * @return Eq<Anon<T>>
   */
  static public function Anon<T>(tag:TAG,fn:T->T->Equaled):Eq<T>{
    return new Anon(fn);
  }
  /**
   * `stx.pico.Nada` instance for `stx.assert.Eq`
   * @param tag 
   * @return Eq<Nada>
   */
  static public function Nada(tag:TAG):Eq<stx.pico.Nada>{
    return new Eq(new Nada());
  }
  /**
   * `std.Bool` instance for `stx.assert.Eq`
   * @param tag 
   * @return Eq<Bool>
   */
  static public function Bool(tag:TAG):Eq<StdBool>{
    return Anon(null,
      (l,r) -> l == r ? AreEqual : NotEqual
    );
  }
  /**
   * `std.Float` instance for `stx.assert.Eq`
   * @param tag 
   * @return Eq<StdFloat>
   */
  static public function Float(tag:TAG):Eq<StdFloat>{
    return Anon(null,
      (l,r) -> l == r ? AreEqual : NotEqual
    );
  }
  /**
   * `std.Array` instance for `stx.assert.Eq`
   * @param tag 
   * @param inner
   * @return Eq<Array<T>>
   */
  static public function Array<T>(tag:TAG,inner:Eq<T>):Eq<StdArray<T>>{
    return new Array(inner);
  }
  /**
   * `stx.nano.Record` instance of `stx.assert.Eq`
   * @param tag 
   * @param l 
   * @param r 
   * @return Eq<stx.Record<T>>
   */
  static public function Record<T>(tag:TAG,inner:Eq<T>):Eq<stx.Record<T>>{
    return new stx.assert.eq.term.Record(inner);
  }
  /**
   * `stx.nano.Cluster` instance of `stx.assert.Eq`
   * @param tag 
   * @param inner 
   * @return Eq<stx.nano.Cluster<T>>
   */
  static public function Cluster<T>(tag:TAG,inner:Eq<T>):Eq<stx.nano.Cluster<T>>{
    return new Cluster(inner);
  }
  /**
   * `stx.nano.Primitive` instance of `stx.assert.Eq`
   * @param tag 
   * @return Eq<stx.nano.Primitive>
   */
  static public function Primitive(tag:TAG):Eq<stx.nano.Primitive>{
    return new Primitive();
  }
  /**
   * `haxe.ds.Option` instance of `stx.assert.Eq`
   * @param tag 
   * @param inner 
   * @return Eq<haxe.ds.Option<T>>
   */
  static public function Option<T>(tag:TAG,inner:Eq<T>):Eq<Option<T>>{
    return new stx.assert.eq.term.Option(inner);
  }
  /**
   * `std.EnumValue` instance of `stx.assert.Eq`
   * @param tag 
   * @return Eq<StdEnumValue>
   */
  static public function EnumValueIndex(tag:TAG):Eq<StdEnumValue>{
    return new EnumValueIndex();
  }
  /**
   * `std.Null` instance of `stx.assert.Eq`
   * @param tag 
   * @param inner 
   * @return Eq<Null<T>>
   */
  static public function NullOr<T>(tag:TAG,inner:Eq<T>):Eq<Null<T>>{
    return new stx.assert.eq.term.NullOr(inner);
  }
  /**
   * `stx.nano.Ident` instance of `stx.assert.Eq`
   * @param tag 
   * @return Eq<Ident>
   */
  static public function Ident(tag:TAG):Eq<Ident>{
    return new stx.assert.eq.term.Ident();
  }
  /**
   * `stx.nano.Register` instance of `stx.assert.Eq`
   * @param tag 
   * @return Eq<Register>
   */
  static public function Register(tag:TAG):Eq<Register>{
    return new stx.assert.eq.term.Register();
  }
  /**
   * `stx.nano.Tup2` instance of `stx.assert.Eq`
   * @param tag 
   * @param inner 
   * @return Eq<stx.nano.Tup2<T>>
   */
  static public function Tup2<L,R>(tag:TAG,l:Eq<L>,r:Eq<R>):Eq<Tup2<L,R>>{
    return new stx.assert.eq.term.Tup2(l,r);
  }
  /**
   * `haxe.ds.StringMap` instance of `stx.assert.Eq`
   * @param tag 
   * @param inner 
   * @return Eq<haxe.ds.StringMap<T>>
   */
  static public function StringMap<T>(tag:TAG,inner:Eq<T>):Eq<haxe.ds.StringMap<T>>{
    return new stx.assert.eq.term.StringMap(inner);
  }
  /**
   * `haxe.Map` instance of `stx.assert.Eq`
   * @param key 
   * @param val 
   * @return Eq<haxe.Map<K,V>>
   */
  static public function Map<K,V>(tag:TAG,val:Eq<V>):Eq<haxe.ds.Map<K,V>>{
    return new stx.assert.eq.term.Map(val);
  }
  /**
   * `nano.OneOrMany` instance of `stx.assert.Eq`
   * @param key 
   * @param val 
   * @return Eq<haxe.Map<K,V>>
   */
   static public function OneOrMany<T>(tag:TAG,val:Eq<T>):Eq<stx.nano.OneOrMany<T>>{
    return new stx.assert.eq.term.OneOrMany(val);
  }
}