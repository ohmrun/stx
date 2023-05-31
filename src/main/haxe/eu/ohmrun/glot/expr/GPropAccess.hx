package eu.ohmrun.glot.expr;

@:using(eu.ohmrun.glot.expr.GPropAccess.GPropAccessLift)
enum abstract GPropAccessSum(String) from String{
  var GPAccFn        = "get";
  var GPAccDefault   = "default";
  var GPAccNull      = "null";
  var GPAccNever     = "never";

  public function toString():String{
    return this;
  }
}
class GPropAccessCtr extends Clazz{
  public function Fn(){
    return GPropAccess.lift(GPAccFn); 
  }
  public function Default(){
    return GPropAccess.lift(GPAccDefault); 
  }
  public function Null(){
    return GPropAccess.lift(GPAccNull); 
  }
  public function Never(){
    return GPropAccess.lift(GPAccNever); 
  }
}
@:using(eu.ohmrun.glot.expr.GPropAccess.GPropAccessLift)
@:forward abstract GPropAccess(GPropAccessSum) from GPropAccessSum to GPropAccessSum{
    public function new(self) this = self;
  @:noUsing static public function lift(self:GPropAccessSum):GPropAccess return new GPropAccess(self);

  public function prj():GPropAccessSum return this;
  private var self(get,never):GPropAccess;
  private function get_self():GPropAccess return lift(this);

  static public function fromString(str:String){
    return lift(switch(str){
      case "get"      : GPAccFn;
      case "default"  : GPAccDefault;
      case "null"     : GPAccNull;
      case "never"    : GPAccNever;
      default         : throw 'unknown GPropAccessSum instrance: $str';
    });
  }
}
class GPropAccessLift{
  static public function getting(self:GPropAccess){
    return switch(self){
      case GPAccFn        : 'get';
      case GPAccDefault   : 'default';
      case GPAccNull      : 'null';
      case GPAccNever     : 'never';
      default             : throw 'unsupported GPropAcess "#${self}"';
    }
  }
  static public function setting(self:GPropAccess){
    return switch(self){
      case GPAccFn        : 'set';
      case GPAccDefault   : 'default';
      case GPAccNull      : 'null';
      case GPAccNever     : 'never';
      default             : throw 'unsupported HPropAcess "#${self}"';
    }
  }
}