package stx.assert.eq.term;

import stx.nano.OneOrMany as TOneOrMany;

final Eq = __.assert().Eq();

class OneOrMany<T> extends EqCls<TOneOrMany<T>>{

  final inner : Eq<T>;
  public function new(inner){
    this.inner = inner;
  }

  public function comply(a:TOneOrMany<T>,b:TOneOrMany<T>):Equaled{
    return switch([a,b]){
      case [OneOf(xI),OneOf(xII)]     : inner.comply(xI,xII);
      case [ManyOf(xsI),ManyOf(xsII)] : Eq.Cluster(inner).comply(xsI,xsII);
      default                         : Eq.EnumValueIndex().comply(a,b);
    }
  }
}