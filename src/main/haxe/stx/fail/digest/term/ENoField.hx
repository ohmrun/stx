package stx.fail.digest.term;

class ENoField extends stx.fail.Digest.DigestCls{
  @:noUsing static public function make(field_name,pos){
    return new ENoField(field_name,pos);
  } 
  public function new(field_name,?pos:Pos){
    super(
      "01FRQ55MMVX2D7JEHJ6CE4X1NY",'No field "$field_name".',
      LocCtr.instance.Available(pos),
      null
    );
  }
}