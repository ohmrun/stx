package stx.assert.makro.type.eq;

import stx.makro.type.HRef as TRef;

final Eq = __.assert().Eq();

class Ref<T> extends EqCls<TRef<T>>{

  final inner : stx.assert.Eq<T>;

  public function new(inner){
    this.inner = inner;
  }

  public function comply(a:TRef<T>,b:TRef<T>):Equaled{
    //TODO ordering?
    var eq = inner.comply(a.get(),b.get());
    if(eq.is_ok()){
      eq = Eq.String().comply(a.toString(),b.toString());
    }
    return eq;
  }
}