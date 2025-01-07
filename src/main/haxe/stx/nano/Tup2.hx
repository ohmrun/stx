package stx.nano;

@:using(stx.nano.Tup2.Tup2Lift)
enum Tup2<L,R>{
  tuple2(l:L,r:R);
}
class Tup2Lift{
  /**
   * create a function from `fn` that can be applied to a value of `Tup<L,R>`
   * @param self 
   * @return R
   */
  static public inline function detuple<L,R,Z>(self:Tup2<L,R>,fn:L->R->Z):Z{
    return switch(self){
        case tuple2(l,r) : fn(l,r);
    }
  }
  /**
   * consume value by applying `fn` on it.
   * @param self 
   * @param fn 
   * @return Tup2<L,RR>
   */
  static public inline function reduce<L,R,Z>(self:Tup2<L,R>,fn:L->R->Z):Z{
    return switch(self){
      case tuple2(l,r) : fn(l,r);
    }
  }
  /**
   * produce left hand value
   * @param self 
   * @param fn 
   * @return Tup2<L,RR>
   */
  static public inline function fst<L,R>(self:Tup2<L,R>):L{
    return reduce(self,(l,_) -> l);
  }
  /**
   * produce right hand value
   * @param self 
   * @param fn 
   * @return Tup2<L,RR>
   */
  static public inline function snd<L,R>(self:Tup2<L,R>):R{
    return reduce(self,(_,r) -> r);
  }
  /**
   * apply `fn` to `fst`
   * @param self 
   * @param fn 
   * @return Tup2<L,RR>
   */
  static public inline function mapl<L,LL,R>(self:Tup2<L,R>,fn:L->LL):Tup2<LL,R>{
    return reduce(self,(l,r) -> tuple2(fn(l),r));
  }
  /**
   * apply `fn` to `snd`
   * @param self 
   * @param fn 
   * @return Tup2<L,RR>
   */
  static public inline function mapr<L,R,RR>(self:Tup2<L,R>,fn:R->RR):Tup2<L,RR>{
    return reduce(self,(l,r) -> tuple2(l,fn(r)));
  }
  static public inline function toKV<L,R>(self:Tup2<L,R>):stx.nano.KV<L,R>{
    return reduce(self,stx.nano.KV.make);
  }
}