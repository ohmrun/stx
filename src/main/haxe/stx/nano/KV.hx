package stx.nano;

typedef KVDef<K,V> = {
  final key : K;
  final val : V;
}
@:using(stx.nano.KV.KVLift)
@:forward abstract KV<K,V>(KVDef<K,V>) from KVDef<K,V> to KVDef<K,V>{
  
  public function new(self:KVDef<K,V>) this = self;
  @:noUsing static public function lift<K,V>(self:KVDef<K,V>):KV<K,V>{
    return new KV(self);
  }
  @:noUsing static public function make<K,V>(k:K,v:V){
    return lift({key : k, val : v});
  }
  @:from static public function fromObj<K,V>(self:KVDef<K,V>):KV<K,V>{
    return new KV(self);
  }
  @:from static public function fromTup<K,V>(tp:Couple<K,V>):KV<K,V>{
    return new KV({ key : tp.fst(), val : tp.snd()});
  }
  public function toKeyValue():{key : K, value : V}{
    return {
      key   : this.key,
      value : this.val
    }
  }
}
class KVLift{
  static public function map<K,V,U>(self:KVDef<K,V>,fn:V->U):KV<K,U>{
    return {
      key : self.key,
      val : fn(self.val)
    };
  }
  static public function fst<K,V>(self:KVDef<K,V>):K{
    return self.key;
  }
  static public function snd<K,V>(self:KVDef<K,V>):V{
    return self.val;
  }
  static public function into<K,V,Z>(self:KVDef<K,V>,fn:K->V->Z):Z{
    return fn(self.key,self.val);
  }
  static public function decouple<K,V,Z>(self:KVDef<K,V>,fn:K->V->Z):Z{
    return fn(self.key,self.val);
  }
  static public inline function toField<V>(self:KV<String,V>):Field<V>{
    return Field.lift(self);
  }
}