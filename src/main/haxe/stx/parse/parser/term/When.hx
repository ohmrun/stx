package stx.parse.parser.term;

/**
  31/10/22 Was a compiler error where Chunk was passing as Option for `defv` call
**/
class When<I> extends ParserCls<I,I>{
  final f : I -> Bool;
  public function new(fn,?tag,?pos){
    super(tag,pos);
    this.f = fn;
  }
  override public function apply(input:ParseInput<I>):ParseResult<I,I>{
    final result = input.head().fold(
     (x) -> f(x).if_else(
       () -> input.tail().ok(x),
       () -> input.no()
     ),
     (e) -> ParseResult.make(input,None,e),
     ()   -> input.no()
    );
    return result;
  }
}