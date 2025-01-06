package stx.parse.parser.term;

class Failed<P,R> extends Sync<P,R>{
  final reason    : ParseFailure;
  final message   : ParseFailureMessage;

  public function new(reason,?message,?pos:Pos){
    super(pos);
    this.reason     = reason;
    this.message    = message;
  }
  public inline function apply(ipt:ParseInput<P>):ParseResult<P,R>{
    final result = Parse.refuse(ipt,reason,message,pos);
    return result;
  }
}