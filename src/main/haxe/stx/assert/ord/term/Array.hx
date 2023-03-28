package stx.assert.ord.term;

/**
  shortlex oerrdah!!
**/
class Array<T> extends OrdCls<StdArray<T>> {
  var inner : Ord<T>;
  public function new(inner){
    this.inner = inner;
  }
  public function comply(v1: StdArray<T>, v2: StdArray<T>):Ordered {
    var n = v1.length - v2.length;
    return if(n != 0){
      n > 0 ? NotLessThan : LessThan;
    }else if(v1.length == 0){
      NotLessThan;
    }else{
      var v = NotLessThan;
      for (i in 0...v1.length) {
        v = inner.comply(v1[i], v2[i]);
        if(v == LessThan){
          break;
        }
      }
      v;
    }
  }
}
