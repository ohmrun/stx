package stx.fail.digest.term;

class EUndefined extends DigestCls{
  @:noUsing static public function make(pos:Pos){
    return new EUndefined(pos);
  }
  public function new(?pos:Pos){
    super(
      "01FRQ56BJH83N0QXF6ZFJ9Y4MN",
      'Encountered Undefined.',
      LocCtr.instance.Available(pos),
      null
    );
  }
}