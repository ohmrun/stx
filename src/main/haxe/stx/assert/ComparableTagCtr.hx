package stx.assert;

import stx.nano.Couple as StdCouple;


import stx.assert.comparable.term.Primitive;
import stx.assert.comparable.term.Int;
import stx.assert.comparable.term.String;
import stx.assert.comparable.term.Couple;

private typedef TAG = STX<Comparable<Dynamic>>;

class ComparableTagCtr{
  /**
   * `stx.nano.Register` instance of `stx.assert.Comparable`
   * @param tag 
   * @return Comparable<stx.nano.Register>
   */
  static public function Register(tag:TAG):Comparable<stx.nano.Register>{
    return new stx.assert.comparable.term.Register();
  }
  /**
   * `std.Int` instance of `stx.assert.Comparable`
   * @param tag 
   * @return Comparable<StdInt>
   */
  static public function Int(tag:TAG):Comparable<StdInt>{
    return new Int();
  }
  /**
   * `std.String` instance of `stx.assert.Comparable`
   * @param tag 
   * @return Comparable<std.String>
   */
  static public function String(tag:TAG):Comparable<std.String>{
    return new String();
  }
  /**
   * `stx.nano.Couple` instance of `stx.assert.Comparable`
   * @param tag 
   * @param L 
   * @param R 
   * @return Comparable<stx.nano.Couple<L,R>>
   */
  static public function Couple<L,R>(tag:TAG,l,r):Comparable<StdCouple<L,R>>{
    return new Couple(l,r);
  }
  /**
   * `stx.nano.Primitive` instance of `stx.assert.Comparable`
   * @param tag 
   * @return Comparable<stx.nano.Primitive>
   */
  static public function Primitive(tag:TAG):Comparable<stx.nano.Primitive>{
    return new Primitive();
  }
  /**
   * Anon instance of `stx.assert.Comparable`
   * @param tag 
   * @param eq 
   * @param lt
   * @return Comparable<T>
   */
  static public function Anon<T>(tag:TAG,eq:Eq<T>,lt:Ord<T>):Comparable<T>{
    return new stx.assert.comparable.term.Anon(eq,lt);
  }
  /**
   * [Description]
   * @param tag 
   * @param inner 
   * @return Comparable<stx.nano.Cluster<T>>
   */
  static public function Cluster<T>(tag:TAG,inner:Comparable<T>):Comparable<stx.Cluster<T>>{
    return new stx.assert.comparable.term.Cluster(inner);
  }
  /**
   * Lazy instance of `stx.assert.Comparable`
   * @param tag 
   * @param K 
   * @param V 
   * @return Comparable<stx.nano.KV<K,V>>
   */
  static public function Lazy<T>(tag:TAG,?eq:Eq<T>,?lt:Ord<T>):Comparable<T>{
    return new stx.assert.comparable.term.Lazy(eq,lt);
  }
  /**
   * `stx.nano.KV` instance of `stx.assert.Comparable`
   * @param tag 
   * @param K 
   * @param V 
   * @return Comparable<stx.nano.KV<K,V>>
   */
  static public function KV<K,V>(tag:TAG,K:Comparable<K>,V:Comparable<V>):Comparable<stx.nano.KV<K,V>>{
    return new stx.assert.comparable.term.KV(K,V);
  }
}