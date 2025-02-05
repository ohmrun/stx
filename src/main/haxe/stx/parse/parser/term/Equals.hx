package stx.parse.parser.term;

class Equals<I> extends ParserCls<I,I>{
  final value : I;
  public function new(value,?tag,?pos){
    super(tag,pos);
    this.value = value;
  }
  override public function apply(input:ParseInput<I>):ParseResult<I,I>{
    return input.head().fold(
      (vI) 	-> value == vI ? input.tail().ok(vI) : input.no(),
      (e) 	-> ParseResult.make(input,None,e),
      () 		-> input.no()
    );
  }
}