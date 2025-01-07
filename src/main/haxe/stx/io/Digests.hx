package stx.io;

class Digests{
  static public function e_input_closed(digests:stx.Digests,?pos:Pos){
    return CTR.make((pos:Pos) -> new EInputClosed(pos));
  }
}
class EInputClosed extends stx.fail.Digest.DigestCls{
  public function new(?pos:Pos){
    super(
      Uuid.of('28e63d03-0f98-444f-938b-51dd6fe945f9'),
      "Input Closed",
      LocCtr.instance.Available(pos)
    );
  }
}