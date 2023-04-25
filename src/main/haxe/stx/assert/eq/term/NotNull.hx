package stx.assert.eq.term;

class NotNull<T> extends EqCls<T>{
  var eq : Eq<Dynamic>;
  public function new(eq){
    this.eq = eq;
  }
  public function comply(a:T,b:T){
    return switch([a,b]){
      case [null,null]        : AreEqual;
      case [null,_]           : NotEqual;
      case [_,null]           : NotEqual;
      default                 : eq.comply(a,b);
    }
  }
}