package stx.nano.lift;

import tink.core.Error.Pos;

class LiftError{
  static public function report<E>(error:Error<E>):Report<E>{
    return Reported(error);
  }
  // static public function toTinkError<E>(self:Error<E>,code=500):tink.core.Error{
  //   final pos = self.loc.flat_map((x:Loc)-> Option.make(x.get_pos())).defv(null);
  //   final tink_pos : tink.core.Error.Pos = pos;
  //     //((self.loc.flat_map(x -> x.known)).defv(null):tink.core.Error.Pos);
  //   return tink.core.Error.withData(
  //     code, 
  //     'TINK_ERROR', 
  //     Iter.lift(self), 
  //     pos
  //   );
  // }
}