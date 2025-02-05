package stx.parse.parser.term;

class AndL<I,T,U> extends With<I,T,U,T>{
  public function new(l:Parser<I,T>,r:Parser<I,U>,?pos:Pos){
    super(l,r,pos);
  }
  override function check(){
    __.assert().that().exists(lhs);
    __.assert().that().exists(rhs);
  }
  override public inline function transform(lhs:Null<T>,rhs:Null<U>):Option<T>{
    return __.option(lhs);
  }
}