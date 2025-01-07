package stx.coroutine.core;

class ECoroutineStop extends DigestCls{
  @:noUsing static public function make(pos:Pos){
    return new ECoroutineStop(pos);
  } 
  public function new(?pos){
    super(
        '01FRQ77KZBWH5B94085CX40Y02',
        'Coroutine stopped.',
        LocCtr.instance.Available(pos),
        null,
    );
  }
}
class ECoroutineInputHung extends DigestCls{
  @:noUsing static public function make(pos:Pos){
    return new ECoroutineInputHung(pos); 
  }
  public function new(?pos:Pos){
    super(
        "01FRSGYFNGNMAKJT12C1GSM2Y4",
        "Input hung",
        LocCtr.instance.Available(pos),
        null
    );
  }
}
class ECoroutineProvidedValueToStoppedCoroutine extends DigestCls{
  @:noUsing static public function make(pos){
    return new ECoroutineProvidedValueToStoppedCoroutine(pos);
  }
  public function new(?pos:Pos){
    super(
        "01FRSHA2FF3J3MEE5AF9RJ5YE7",
        "Provided value to stopped coroutine",
        LocCtr.instance.Available(pos)
    );
  }
}
class Digests{
  static public function e_coroutine_stop(digests:stx.fail.Digests,?pos:Pos):CTR<Pos,Digest>{
    return ECoroutineStop.make;
  }
  static public function e_coroutine_provided_value_to_stopped_coroutine(digests:stx.fail.Digests,?pos:Pos):CTR<Pos,Digest>{
    return ECoroutineProvidedValueToStoppedCoroutine.make;
  }
}