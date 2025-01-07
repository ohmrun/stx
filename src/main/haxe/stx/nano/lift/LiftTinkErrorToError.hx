package stx.nano.lift;

class LiftTinkErrorToError{
  static public inline function toError<E>(self:tink.core.Error):Error<E>{
    return ErrorCtr.instance.Digest(
      stx.Nano.digests(__).e_tink_error(self.message,self.code).apply(self.pos)
    );
  }
}