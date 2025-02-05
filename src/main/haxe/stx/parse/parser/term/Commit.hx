package stx.parse.parser.term;

class Commit<I,T> extends Base<I,T,Parser<I,T>>{
  override public inline function apply(ipt:ParseInput<I>):ParseResult<I,T>{
    return mod(delegation.apply(ipt));
  }
  private function mod(result:ParseResult<I,T>){
    return result.is_ok().if_else(
      () -> result,
      //|| result.is_parse_fail()?
      () -> (!result.is_fatal()).if_else(
        () -> result,
        () -> result.defect(
          ErrorCtr.instance.Make(_ -> 
            (new ParseLapse(FATAL,E_Parse_CanNotCommit,result.asset.index):Lapse<ParseFailure>).enlist()
        ))
      )
    );
  }
}