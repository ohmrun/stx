package stx.assert.ord.term;

class Option<T> extends OrdCls<StdOption<T>>{
  public var inner(default,null):Ord<T>;
  public function new(inner){
    this.inner = inner;
  }
  public function comply(lhs:StdOption<T>,rhs:StdOption<T>):Ordered{
    return lhs.zip(rhs).map(
      __.decouple( (l:T,r:T) -> inner.comply(l,r) )
    ).defv(NotLessThan);
  }
}