package stx.parse.parser.term;

/**
 * Takes the head of the input and passes it through `f`.
 * If `f` returns `Some` counts as a success, `None` counts as failure.
 */
class Choose<I,O> extends ParserCls<I,O>{
  final f : I -> StdOption<O>;
  public function new(fn:I->StdOption<O>,tag:Option<String>,?pos:Pos){
    super(tag,pos);
    this.f = fn;
  }
  override inline public function apply(ipt:ParseInput<I>):ParseResult<I,O>{ 
    return ipt.head().fold(
      o -> f(o).fold(
        ok  -> ipt.drop(1).ok(ok),
        ()  -> ipt.no(E_Parse_PredicateFailed)
      ),
      e   -> ipt.no(E_Parse_PredicateFailed).defect(e),
      ()  -> ipt.no(E_Parse_PredicateFailed)
    );
  }
}