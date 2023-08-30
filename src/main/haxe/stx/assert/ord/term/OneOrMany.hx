package stx.assert.ord.term;

import stx.nano.OneOrMany as TOneOrMany;

final Ord = __.assert().Ord();

class OneOrMany<T> extends OrdCls<TOneOrMany<T>>{

  final inner : Ord<T>;
  public function new(inner){
    this.inner = inner;
  }

  public function comply(a:TOneOrMany<T>,b:TOneOrMany<T>):Ordered{
    return switch([a,b]){
      case [OneOf(xI),OneOf(xII)]     : inner.comply(xI,xII);
      case [ManyOf(xsI),ManyOf(xsII)] : Ord.Cluster(inner).comply(xsI,xsII);
      default                         : Ord.EnumValueIndex().comply(a,b);
    }
  }
}