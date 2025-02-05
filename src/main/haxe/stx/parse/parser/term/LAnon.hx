package stx.parse.parser.term;

class LAnon<I,O> extends Delegate<I,O>{
  var closure : Void -> Parser<I,O>;

  public function new(closure:Void->Parser<I,O>,?id:Pos){
    super(null,id);
    #if test
    __.assert().that().exists(closure);
    #end
    this.closure = closure;//.fn().cache().prj();
  }
  private function open(){
    this.delegation = closure();
  }
  override public inline function apply(ipt:ParseInput<I>):ParseResult<I,O>{
    return if(delegation == null){
      open();
      __.assert().that().exists(delegation);
      this.delegation.apply(ipt);
    }else{
      this.delegation.apply(ipt);
    }
  } 
}