package stx.fail.digest.term;

class EResourceNotFound extends DigestCls{
  @:noUsing static public function make(resource_name,pos:Pos){
    return new EResourceNotFound(resource_name,pos);
  }
  public function new(resource_name,?pos:Pos){
    super(
        "01FRQ55MMVX2D7JEHJ6CE4X1NY",
        'Resource "$resource_name" not found.',
        LocCtr.instance.Available(pos),
        -1
    );
  }
}