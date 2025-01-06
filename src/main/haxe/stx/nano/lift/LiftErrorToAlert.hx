package stx.nano.lift;

class LiftErrorToAlert{
  static public inline function alert<E>(self:Error<E>):Alert<E>{
    return Alert.pure(self);  
  }
}