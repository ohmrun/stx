package stx.ds.xset;

@:using(stx.ds.xset.XSetVal.XSetValLift)
enum XSetValSum<K,V>{
  SetObj(key:K,val:XSet<K,V>);
  SetVal(key:K,val:V);
}
@:using(stx.ds.xset.XSetVal.XSetValLift)
abstract XSetVal<K,V>(XSetValSum<K,V>) from XSetValSum<K,V> to XSetValSum<K,V> {
  static public var _(default,never) = XSetValLift;
  @:noUsing static public function lift<K,V>(self:XSetValSum<K,V>){
    return new XSetVal(self);
  }
  public function new(self:XSetValSum<K,V>) this = self;
  public function fst():K{
    return switch(this){
      case SetVal(k,_) : k;
      case SetObj(k,_) : k;
    }
  }
  public function snd():Either<XSet<K,V>,V>{
    return switch(this){
      case SetObj(_,v) : Left(v);
      case SetVal(_,v) : Right(v);
    }
  }
  @:from static public function fromObjCouple<K,V>(couple:Couple<K,XSet<K,V>>):XSetVal<K,V>{
    return lift(couple.decouple(SetObj));
  }
  @:from static public function fromValCouple<K,V>(couple:Couple<K,V>):XSetVal<K,V>{
    return lift(couple.decouple(SetVal));
  }
  public function fold<Z>(obj:K -> XSet<K,V> -> Z, val : K -> V -> Z):Z{
    return _.fold(this,obj,val);
  }
  public var field(get,never):K;
  private function get_field(){
    return fst();
  }
  public function toString(){
    return _.toString(this);
  }
}
class XSetValLift{
  static public function fold<K,V,Z>(self:XSetValSum<K,V>,obj:K -> XSet<K,V> -> Z, val : K -> V -> Z):Z{
    return switch(self){
      case SetObj(k,v)  : obj(k,v);
      case SetVal(k,v)  : val(k,v);
    }
  }
  static public function toString<K,V>(self:XSetValSum<K,V>){
    return self.fold(
      (k,v) -> '$k => $v',
      (k,v) -> '$k => $v'
    );
  }
}