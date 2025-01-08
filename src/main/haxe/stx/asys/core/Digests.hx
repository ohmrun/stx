package stx.asys.core;

import stx.assert.eq.term.Unknown;

class EUnknownDistro extends DigestCls{
  @:noUsing static public function make(name,pos){
    return new EUnknownDistro(name,pos);
  } 
  public function new(name,?pos:Pos){
    super('01FRQ6VSNTCEKZYDAZG4G560KP','No distro named $name',Loc.fromPos(pos));
  }
}
/**
  This relates to both the Input `Coroutine` being in an a `Wait` state, and the Process `Server requiring a request. ie `Yield(state,fn)`.
**/
class EInputParserWaitingOnAnUninitializedProcess extends DigestCls{
  @:noUsing static public function make(pos){
    return new EInputParserWaitingOnAnUninitializedProcess(pos);
  }
  public function new(?pos:Pos){
    super(
      "01FS6V9R64369F8T5WFZ3S7VRS",
     "Process is unitialized and the Input Parser has requested no input",
      LocCtr.instance.Available(pos)
      );
  }
}
class EInputUnexpectedEnd extends DigestCls{
  @:noUsing static public function make(pos:Pos){
    return new EInputUnexpectedEnd(pos);
  }
  public function new(?pos){
    super("01FS95PFFZX8Y6MX1J0JEXAT4Y","Input ended unexpectedly",LocCtr.instance.Available(pos));
  }
}
class EInputUnexpectedResponse extends DigestCls{
  @:noUsing static public function make(pos:Pos){
    return new EInputUnexpectedResponse(pos);
  }
  public function new(?pos){
    super("01FS95TMG8KDWWA98MEVW74C37","Input ended unexpectedly",LocCtr.instance.Available(pos));
  }
}
class Digests{
  static public function e_unknown_distro(digests:stx.fail.Digests,name):CTR<Pos,Digest>{
    return EUnknownDistro.make.bind(name);
  }
  static public function e_input_parser_waiting_on_an_unitialized_process(digests:stx.fail.Digests):CTR<Pos,Digest>{
    return EInputParserWaitingOnAnUninitializedProcess.make;
  }
  static public function e_input_unexpected_end(digests:stx.fail.Digests):CTR<Pos,Digest>{
    return EInputUnexpectedEnd.make;
  }
  static public function e_input_unexpected_response(digests:stx.fail.Digests):CTR<Pos,Digest>{
    return EInputUnexpectedResponse.make;
  }
}