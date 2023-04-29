package stx.assert.eq.term;

class Option<T> extends EqCls<StdOption<T>>{
  var eq : Eq<T>;
  public function new(eq){
    this.eq = eq;
  }
  public function comply(a:StdOption<T>,b:StdOption<T>):Equaled{
    return switch([a,b]){
      case [Some(l),Some(r)]          : eq.comply(l,r);
      case [None,None]                : true;
      default                         : false;
    }
  }
}