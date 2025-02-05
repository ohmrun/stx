package stx.parse.parser.term;

class AndR<I,T,U> extends With<I,T,U,U>{
  public function new(l:Parser<I,T>,r:Parser<I,U>,?pos:Pos){
    #if test
    __.assert().that().exists(l);
    __.assert().that().exists(r);
    #end
    super(l,r,pos);
  }
  override function check(){
    // __.assert().that().exists(delegation);
  }
  override public inline function transform(lhs:Null<T>,rhs:Null<U>):Option<U>{
    #if debug 
    __.log().trace(_ -> _.thunk(() -> '${lhs} $lhs ${rhs} $rhs'));
    #end 
    return __.option(rhs);
  }
}