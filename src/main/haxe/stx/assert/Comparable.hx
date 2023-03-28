package stx.assert;

import stx.nano.Couple as StdCouple;

import stx.assert.comparable.term.Primitive;
import stx.assert.comparable.term.Int;
import stx.assert.comparable.term.String;
import stx.assert.comparable.term.Couple;


interface ComparableApi<P> extends EqualableApi<P> extends OrderableApi<P>{
  public function toComparable():Comparable<P>;
} 
abstract class ComparableCls<P> implements ComparableApi<P>{
  abstract public function eq():Eq<P>;
  abstract public function lt():Ord<P>;

  public function toComparable():Comparable<P>{
    return this;
  }
  
}
@:forward abstract Comparable<T>(ComparableApi<T>) from ComparableApi<T> to ComparableApi<T>{
  
  public function new(self) this = self;
  
  @:noUsing static public function Register():Comparable<stx.nano.Register>{
    return new stx.assert.comparable.term.Register();
  }
  @:noUsing static public function Int():Comparable<StdInt>{
    return new Int();
  }
  @:noUsing static public function String():Comparable<StdString>{
    return new String();
  }
  @:noUsing static public function Couple<L,R>(l,r):Comparable<StdCouple<L,R>>{
    return new Couple(l,r);
  }
  @:noUsing static public function Primitive():Comparable<stx.nano.Primitive>{
    return new Primitive();
  }
  @:noUsing static public function Anon<T>(eq:Eq<T>,lt:Ord<T>):Comparable<T>{
    return new stx.assert.comparable.term.Anon(eq,lt);
  }
  @:noUsing static public function Cluster<T>(inner:Comparable<T>):Comparable<stx.Cluster<T>>{
    return new stx.assert.comparable.term.Cluster(inner);
  }
  @:noUsing static public function Lazy<T>(?eq:Eq<T>,?lt:Ord<T>):Comparable<T>{
    return new stx.assert.comparable.term.Lazy(eq,lt);
  }
  @:noUsing static public function KV<K,V>(K:Comparable<K>,V:Comparable<V>):Comparable<stx.nano.KV<K,V>>{
    return new stx.assert.comparable.term.KV(K,V);
  }
  public function copy(?eq:Eq<T>,?lt:Ord<T>):Comparable<T>{
    return Anon(
      __.option(eq).defv(this.eq()),
      __.option(lt).defv(this.lt())
    );
  }
  public function is_greater_or_equal(self:T,that:T):Bool{
    return this.eq().comply(self,that).is_equal().if_else(
      () -> true,
      () -> this.lt().comply(that,self).is_less_than()
    );
  }
}