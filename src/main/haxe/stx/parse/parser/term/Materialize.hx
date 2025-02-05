package stx.parse.parser.term;

class Materialize<I,O> extends stx.parse.parser.term.Delegate<I,O>{
  override public function apply(ipt:ParseInput<I>):ParseResult<I,O>{
    final result = delegation.apply(ipt);
    return 
      if(result.is_defined()){
        result;
      }else{
        result.asset.no(E_Parse_NoOutput);
      }
  }
}