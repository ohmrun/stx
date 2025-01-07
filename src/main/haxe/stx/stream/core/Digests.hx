package stx.stream.core;

class Digests{
  static public function e_end_called_twice(digests:stx.fail.Digests,?pos:Pos):CTR<Pos,Digest>{
    return EEndCalledTwice.make;
  }
}
class EEndCalledTwice extends DigestCls{
  @:noUsing static public function make(pos:Pos){
    return new EEndCalledTwice(pos);
  }
  public function new(?pos){
    super(
      "01FRQ80PZA3A57AZPXPQA7Z8YT",
      "End called twice",
      LocCtr.instance.Available(pos)
    );
  }
}
