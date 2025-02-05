package stx.parse.parser.term;

class Failed<P,R> extends ParserCls<P,R>{
  final reason    : ParseFailure;
  final message   : ParseFailureMessage;

  public function new(reason,?message,?pos:Pos){
    super(pos);
    this.reason     = reason;
    this.message    = message;
  }
  override public inline function apply(ipt:ParseInput<P>):ParseResult<P,R>{
    final result = ipt.refuse(reason,message,pos);
    return result;
  }
}