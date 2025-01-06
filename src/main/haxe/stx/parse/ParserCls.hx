package stx.parse;

abstract class ParserCls<P,R> implements ParserApi<P,R> extends Clazz{
  public function new(?tag:Option<String>,?pos:Pos){
    super();
    this.pos    = pos;
    this.tag    = __.option(tag).flatten().defv(this.identifier().name);
  }
  public final pos                              : Pos;
  
  public var tag                                : Option<String>;
 
  abstract public function apply(p:ParseInput<P>):ParseResult<P,R>;
  
  public inline function asParser():Parser<P,R>{
    return new Parser(this);
  }
  public function toString(){
    return this.identifier().name;
  }
}