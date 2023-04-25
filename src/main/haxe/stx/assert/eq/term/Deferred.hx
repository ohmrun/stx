package stx.assert.eq.term;

class Deferred<T> extends EqCls<T>{
  var eq      : Eq<T>;

  public function new(){};

  public function comply(a:T,b:T){
    if(eq == null){
      if(a == null){
        eq = Equal.getEqualFor(a);
      }else{
        eq = Equal.getEqualFor(b);
      }
    }
    return eq.comply(a,b);
  }
}