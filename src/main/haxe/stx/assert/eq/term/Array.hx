package stx.assert.eq.term;

class Array<V> extends EqCls<StdArray<V>>{
  var inner : Eq<V>;

  public function new(inner){
    this.inner = inner;
  }
  public function comply(a:StdArray<V>,b:StdArray<V>):Equaled{

    var ok = AreEqual;

    if(a.length!=b.length){
      return NotEqual;
    }

    for(i in 0...a.length-1){
      var lhs = a[i];
      var rhs = b[i];
      ok = inner.comply(lhs,rhs);
      if(!ok.is_ok()){break;}
    }
    return ok;
  }
}