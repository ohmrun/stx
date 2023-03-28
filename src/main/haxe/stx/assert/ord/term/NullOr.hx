package stx.assert.ord.term;

//TODO: this is Exists
class NullOr<T> extends OrdCls<Null<T>>{
  public var inner(default,null):Ord<T>;
  public function new(inner){
    this.inner = inner;
  }
  public function comply(lhs:Null<T>,rhs:Null<T>):Ordered{
    return switch([lhs,rhs]){
      case [null,null] : NotLessThan;
      case [x,null]    : NotLessThan;
      case [null,x]    : LessThan;
      case [x,y]       : inner.comply(cast x,cast y);
    }
  }
}