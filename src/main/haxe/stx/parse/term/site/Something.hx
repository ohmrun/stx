package stx.parse.term.site;

class Something<I:{ site : Site }> extends stx.parse.parser.term.Sync<String,String>{
  inline public function apply(input:ParseInput<String>):ParseResult<String,String>{
    return if(input.is_end()){
      input.eof();
    }else{
      #if debug
      __.log().trace('${input.head().def(null)}');
      #end
      input.head().fold(
        v 	-> input.tail().ok(v),
        e   -> ParseResult.make(input,None,e),
        () 	-> input.no()
      );
    }
  }
  override public function toString(){
    return "*";
  }
}