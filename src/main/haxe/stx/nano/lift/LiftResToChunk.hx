package stx.nano.lift;

import stx.nano.Chunk;

class LiftResToChunk{
  static public function toChunk<O,E>(self:Upshot<O,E>):Chunk<O,E>{
    return self.fold(
      (o) -> Val(o),
      (e) -> End(e)
    );
  }
}