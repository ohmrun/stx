package stx.fail.digest.term;

class EUnimplemented extends DigestCls{
  @:noUsing static public function make(name:String,pos:Pos){
    return new EUnimplemented(name,pos);
  }
  public function new(name:String,?pos:Pos){
    super(
      "01FRQ86121X4G17EEQ7DDNVEHH",
      'Unimplemented $name',
      LocCtr.instance.Available(pos),
      -1
    );
  }
}