package stx.parse.parser.term;

class Succeed<P,R> extends ParserCls<P,R>{
  final v : R;
  public function new(value:R,?pos:Pos){
    __.assert().that().exists(value);
    super(None,pos);
    this.v = value;
  }
  @:noUsing static inline public function pure<P,R>(r:R):Parser<P,R>{
    return new Succeed(r).asParser();
  }
  override public inline function apply(ipt:ParseInput<P>):ParseResult<P,R>{
    return ipt.ok(this.v);
  }
}