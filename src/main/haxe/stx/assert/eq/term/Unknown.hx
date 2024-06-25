package stx.assert.eq.term;

class Unknown extends EqCls<Dynamic>{
  public function new(){}
  public function comply(a:Dynamic,b:Dynamic):Equaled{
    return if(Reflect.hasField(a,'equals')){
      new HasFunction().comply(a,b);
    }else{
      new Object().comply((a:Any),(b:Any));
    }
  }
}