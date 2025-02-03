package stx.parse.parser.term;

/**
 * Parser that produces a single value from the input if one exists.
 */
class Something<I> extends Sync<I,I>{
  inline public function apply(input:ParseInput<I>):ParseResult<I,I>{
    return if(input.is_end()){
      input.eof();
    }else{
      #if debug
      __.log().trace('${input.head().def(null)}');
      #end
      input.head().fold(
        v 	-> input.tail().ok(v),
        e 	-> ParseResult.make(input,None,e),
        () 	-> input.tail().no()
      );
    }
  }
  override public function toString(){
    return "*";
  }
}