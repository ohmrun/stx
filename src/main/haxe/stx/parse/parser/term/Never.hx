package stx.parse.parser.term;

class Never<I> extends Sync<I,I>{
  override public function apply(input:ParseInput<I>):ParseResult<I,I>{
    return input.no();
  }
}