package stx.nano.lift;

class LiftOptionNano{
  static public function zip<T,TT>(self:OptionSum<T>,that:OptionSum<TT>):OptionSum<Couple<T,TT>>{
    return switch([self,that]){
      case [Some(l),Some(r)]  : Some(Couple.make(l,r));
      default                 : None;
    }
  }
  /**
   * `__.crack()` if `self` is not defined, returns value otherwise.
   * @param self 
   * @param fn 
   * @param pos 
   * @return T
   */
  //TODO (09-05-2023) use CTR
  @stx.fudge
  static public inline function fudge<T,E>(self:Null<Option<T>>,?err:CTR<Fault,Error<E>>,?pos:Pos):T{
    return switch(self){
      case Some(v)  : v;
      case None if(err == null)     :
        Fault.make(pos).digest((_:Digests) -> _.e_undefined()).crack();
        null;
      case None : 
        err.apply(pos).crack();
        null;
    }    
  }
  /**
   * Helper to lift an `Option` to an `Upshot` using `CTR<Fault,Error<E>>`
   * @param self 
   * @param fn 
   * @param pos 
   * @return Upshot<T,E>
   */
  static public function resolve<T,E>(self:Option<T>,fn:CTR<Fault,Error<E>>,?pos:Pos):Upshot<T,E>{
    return self.fold(
      Accept,
      () -> Reject(fn.apply(Fault.make(pos)))
    );
  }
}