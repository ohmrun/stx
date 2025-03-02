package stx.nano;

typedef TimerDef = {
  var created(default,null) : Float;
}
/**
  Immutable interface Timer.
**/
//TODO make
//@:stx.make('unit')
@:forward abstract Timer(TimerDef) from TimerDef to TimerDef{
  public function new(?self){
    if(self == null){
      this = unit();
    }else{
      this = self;
    }
  }
  //TODO should `pure` be only open type?
  @:noUsing static public function pure(v:Float):Timer{
    return {
      created : v
    };
  }
  @:noUsing static public function unit():Timer{
    return pure(mark());
  }
  static public function mark():Float{
    return haxe.Timer.stamp();
  }
  function copy(?created:Float){
    return pure(created == null ? this.created : created);
  }
  public function start():Timer{
    return copy(mark());
  }
  public function since():Float{
    return mark() - this.created;
  }
  function prj(){
    return this;
  }
}