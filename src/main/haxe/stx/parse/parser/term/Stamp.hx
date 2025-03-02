package stx.parse.parser.term;

class Stamp<P,R> extends ParserCls<P,R>{
  public var value(default,null):ParseResult<P,R>;
  public function new(value,?pos:Pos){
    super(pos);
    this.value = value;
  }
  override inline public function apply(input:ParseInput<P>):ParseResult<P,R>{
    return value;
  }
  override public function toString(){
    return 'Stamp($value)';
  }
}