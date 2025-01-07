package stx.fail.digest.term;

class ETinkError extends DigestCls{
  @:noUsing static inline public function make(msg,code,pos){
    return new ETinkError(msg,code,pos);
  }
  public function new(msg,code,?pos){
    super(
      "01FRQ5TP22YD13E22X767DTHJC",
      msg,
      LocCtr.instance.Available(pos),
      code
    );
  }
}