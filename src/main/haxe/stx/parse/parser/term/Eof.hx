package stx.parse.parser.term;

class Eof<I,O> extends Sync<I,O>{
  override public function apply(input:ParseInput<I>):ParseResult<I,O>{
    return input.is_end() ? input.nil() : input.no(E_Parse_NotEof,this.pos);
  }
}