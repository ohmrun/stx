package stx.assert.eq.term;

class Unknown implements EqApi<Dynamic> extends Clazz{

  public function comply(a:Dynamic,b:Dynamic){
    return if(Reflect.hasField(a,'equals')){
      new HasFunction().comply(a,b);
    }else{
      new Object().comply((a:Any),(b:Any));
    }
  }
}