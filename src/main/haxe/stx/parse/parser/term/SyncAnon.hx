package stx.parse.parser.term;

class SyncAnon<P,R> extends SyncBase<P,R,ParseInput<P> -> ParseResult<P,R>>{
  
  private final method : ParseInput<P> -> ParseResult<P,R>;
  public function new(method:ParseInput<P> -> ParseResult<P,R>,tag:Option<String>,?pos:Pos){
    super(tag,pos);
    this.method = method;
  }
  override public function apply(ipt:ParseInput<P>):ParseResult<P,R>{
    #if test
      __.assert().that().exists(pos);
    #end
    final result = method(ipt);
    //trace('$this $result');
    return result;
  }
  override public function toString(){
    return 'SyncAnon($tag)';
  }
}
class SyncAnonLift{
  
}