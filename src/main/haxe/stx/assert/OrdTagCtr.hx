package stx.assert;

import stx.assert.Module;

import stx.assert.ord.term.*;
import stx.assert.ord.term.Couple;
import stx.assert.ord.term.KV;
import stx.assert.ord.term.EnumValueIndex;
import stx.assert.ord.term.Array;
import stx.assert.ord.term.Cluster;
import stx.assert.ord.term.String;
import stx.assert.ord.term.Int;
import stx.assert.ord.term.Int64;
import stx.assert.ord.term.Float;
import stx.assert.ord.term.Anon;
import stx.assert.ord.term.Primitive;

private typedef TAG = STX<Ord<Dynamic>>;
/**
 * `STX` tag contructors for `stx.assert.Ord`
 */
class OrdTagCtr{
  static public inline function Int(tag:TAG):Ord<StdInt>{
    return new Int();
  }
  static public inline function Int64(tag:TAG):Ord<haxe.Int64>{
    return new Int64();
  }
  static public inline function Float(tag:TAG):Ord<StdFloat>{
    return new Float();
  }
  static public inline function String(tag:TAG):Ord<StdString>{
    return new String();
  }
  static public inline function Couple<L,R>(tag:TAG, l,r):Ord<stx.nano.Couple<L,R>>{
    return new Couple(l,r);
  }
  static public inline function KV<L,R>(tag:TAG, l,r):Ord<stx.nano.KV<L,R>>{
    return new KV(l,r);
  }
  static public inline function Anon<T>(tag:TAG, fn:T->T->Ordered):Ord<T>{
    return new Anon(fn);
  }
  static public inline function Bool(tag:TAG):Ord<StdBool>{
    return Anon(null,
      (lhs:StdBool,rhs:StdBool) -> lhs == rhs ? NotLessThan : lhs == false ? LessThan : NotLessThan
    );
  }
  static public inline function Primitive(tag:TAG):Ord<stx.nano.Primitive>{
    return new Primitive();
  }
  static public inline function Array<T>(tag:TAG,inner:Ord<T>):Ord<StdArray<T>>{
    return new Array(inner);
  }
  static public inline function Record<T>(tag:TAG, inner:Ord<T>):Ord<stx.Record<T>>{
    return new stx.assert.ord.term.Record(inner);
  }
  static public inline function Cluster<T>(tag:TAG, inner:Ord<T>):Ord<stx.Cluster<T>>{
    return new Cluster(inner);
  }
  static public inline function Option<T>(tag:TAG, inner:Ord<T>):Ord<StdOption<T>>{
    return new stx.assert.ord.term.Option(inner);
  }
  static public inline function NullOr<T>(tag:TAG, inner:Ord<T>):Ord<Null<T>>{
    return new stx.assert.ord.term.NullOr(inner).toOrdApi();
  }
  static public inline function EnumValueIndex(tag:TAG):Ord<StdEnumValue>{
    return new EnumValueIndex();
  }
  static public inline function Ident(tag:TAG):Ord<Ident>{
    return new stx.assert.ord.term.Ident();
  }
  static public inline function Register(tag:TAG):Ord<Register>{
    return new stx.assert.ord.term.Register();
  }
  static public inline function Exists(tag:TAG):Ord<Dynamic>{
    return new stx.assert.ord.term.Exists();
  }
  static public inline function Tup2<L,R>(tag:TAG,l:Ord<L>,r:Ord<R>):Ord<Tup2<L,R>>{
    return new stx.assert.ord.term.Tup2(l,r);
  }
  static public function Map<K,V>(tag:TAG,k:Ord<K>,v:Ord<V>):Ord<haxe.ds.Map<K,V>>{
    return new stx.assert.ord.term.Map(k,v);
  }
}