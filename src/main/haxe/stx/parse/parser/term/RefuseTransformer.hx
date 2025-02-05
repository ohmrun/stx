package stx.parse.parser.term;

class ErrorTransformer<I,O> extends Base<I,O,Parser<I,O>>{
  var transformer : Error<ParseFailure> -> Error<ParseFailure>;
  public function new(delegation,transformer,?pos:Pos){
    super(delegation,pos);
    this.transformer = transformer;
  }
  override inline public function apply(input:ParseInput<I>):ParseResult<I,O>{
    final result = delegation.apply(input);
    return mod(result);
  }
  private function mod(result:ParseResult<I,O>):ParseResult<I,O>{
    //__.log().trace(_ -> _.thunk(() -> delegation));
    //__.log().trace(result.is_ok());
    final out = ParseResult.make(result.asset,result.value,transformer(result.error));
    //__.log().trace(out.is_ok());
    return ParseResult.lift(out);
  }
  override public function toString(){
    return this.delegation.toString();
  }
}