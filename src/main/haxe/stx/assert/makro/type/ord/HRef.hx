package stx.assert.makro.type.ord;

import stx.makro.type.HRef as TRef;

final Ord = __.assert().Ord();

class HRef<T> extends OrdCls<TRef<T>>{

  final inner : stx.assert.Ord<T>;

  public function new(inner){
    this.inner = inner;
  }

  public function comply(a:TRef<T>,b:TRef<T>):Ordered{
    //TODO ordering?
    var ord = inner.comply(a.get(),b.get());
    if(ord.is_not_less_than()){
      ord = Ord.String().comply(a.toString(),b.toString());
    }
    return ord;
  }
}