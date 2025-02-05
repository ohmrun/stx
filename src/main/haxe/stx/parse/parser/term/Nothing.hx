package stx.parse.parser.term;

class Nothing<I,O> extends Sync<I,O>{
  override public function apply(input:ParseInput<I>):ParseResult<I,O>{
    return input.nil();
  }
}