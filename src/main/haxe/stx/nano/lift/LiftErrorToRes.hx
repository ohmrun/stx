package stx.nano.lift;

class LiftErrorToRes{
  static inline public function toUpshot<T,E>(self:Error<E>):Upshot<T,E>{
    return Reject(self);
  }
  static inline public function reject<T,E>(self:Error<E>):Upshot<T,E>{
    return Reject(self);
  }
}