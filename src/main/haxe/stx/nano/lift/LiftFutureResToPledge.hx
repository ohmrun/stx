package stx.nano.lift;

class LiftFutureResToPledge{
  static public function toPledge<T,E>(self:Future<Res<T,E>>):Pledge<T,E>{
    return Pledge.lift(self);
  }
}