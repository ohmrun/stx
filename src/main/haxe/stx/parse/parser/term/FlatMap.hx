package stx.parse.parser.term;

/**
 * The `ParserInput` going into the return of `flat_map` is the original and not that of the `ParseResult` of `delegate`
 * @see `AndThen`
 */
abstract class FlatMap<P,Ri,Rii> extends ParserCls<P,Rii>{
  public function new(delegate,?pos:Pos){
    super(pos);
    this.delegate = delegate;
  }
  final delegate : Parser<P,Ri>;
  abstract function flat_map(rI:Ri):Parser<P,Rii>;
  @:privateAccess override public inline function apply(input:ParseInput<P>):ParseResult<P,Rii>{
    final ok = this.delegate.apply(input);

    final after = through_bind(input,ok);
    return after.apply(input); 
  }
  function through_bind(input:ParseInput<P>,result:ParseResult<P,Ri>):Parser<P,Rii>{
    return result.has_error().if_else(
      () -> new Stamp(ParseResult.fromEquity(result.clear())).asParser(),
      () -> __.option(result.value).flat_map(x -> x).fold(
        ok -> flat_map(ok),
        () -> Parsers.Stamp(input.no())
      )
    );
  }
}