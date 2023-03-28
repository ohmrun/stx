package eu.ohmrun.halva;

import eu.ohmrun.halva.Core;

interface AggregationApi<K,V>{
  public function bestow(k:K,v:LVar<V>):Bool;
  public function obtain(k:K):Future<Option<LVar<V>>>;
  public function exists(k:K):Bool;
  public function assume(k:K):Bool;
  public function values():Iterable<K>;
}
class AggregationCls<K,V> implements AggregationApi<K,V>{
  final accretion   : Accretion<V>;
  final history     : haxe.ds.Map<Register,ThresholdSet<V>>;
  final internal    : haxe.ds.Map<K,Register>;
  public function new(satisfies,data,internal:Map<K,Register>){
    this.accretion = new AccretionCls(satisfies,data);
    this.internal = internal;
    this.history  = new haxe.ds.Map();
  }
  public function assume(k:K):Bool{
    return this.bestow(k,BOT);
  }
  public function bestow(k:K,v:LVar<V>):Bool{
    var register = internal.get(k);
    if(register == null){
      register = this.accretion.create();
    }
    var hist = this.history.get(register);
    if(hist == null){
      hist = RedBlackSet.make(this.accretion.satisfies.toComparable());
    }
    this.history.set(register,hist.put(v));

    return this.accretion.update(register,v).if_else(
      () -> {
        this.internal.set(k,register);
        return true;
      },
      () -> {
        return false;
      }
    );
  }
  public function obtain(k:K):Future<Option<LVar<V>>>{
    final register = internal.get(k);
    return if(register == null){
      Future.irreversible((cb) -> cb(None));
    }else{
      final hist = __.option(history.get(register)).def(
        () -> RedBlackSet.make(this.accretion.satisfies.toComparable())
      );
      this.accretion.redeem(register,hist);
    }
  }
  public function listen(k:K){
    final register = internal.get(k);
    final hist = __.option(history.get(register)).def(
      () -> RedBlackSet.make(this.accretion.satisfies.toComparable())
    );
    return this.accretion.listen(register,hist);
  }
  public function exists(k:K):Bool{
    return this.internal.exists(k);
  }
  public function values():Iterable<K>{
    return {
      iterator : () -> {
        final iter = internal.keyValueIterator();
        return {
          next : () -> {
            final kv = iter.next();
            return kv.key; 
          },
          hasNext : () -> {
            return iter.hasNext();
          }
        }
      }
    }
  }
}