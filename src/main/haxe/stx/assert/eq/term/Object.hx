package stx.assert.eq.term;

class Object implements EqApi<Any> extends Clazz{
  public function comply(a:Any,b:Any):Equaled{
    var o = AreEqual;

    for(key in Reflect.fields(a)) {
      var va = Reflect.field(a, key);
      if(!Equal.getEqualFor(va).comply(va, Reflect.field(b, key)).is_ok()){
        o = NotEqual;
        break;
      }
    }
    return o;
  }
}