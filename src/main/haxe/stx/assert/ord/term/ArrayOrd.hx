package stx.assert.ord.term;

/**
  shortlex oerrdah!!
**/
class ArrayOrd<T> extends OrdCls<std.Array<T>> {
  var inner : Ord<T>;
  public function new(inner:Ord<T>){
    this.inner = inner;
  }
  public function comply(v1: std.Array<T>, v2: std.Array<T>):Ordered {
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
