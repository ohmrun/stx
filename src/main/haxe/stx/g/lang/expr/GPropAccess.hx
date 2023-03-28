package stx.g.lang.expr;

@:using(stx.g.lang.expr.GPropAccess.GPropAccessLift)
enum GPropAccessSum{
  GPAccFn;
  GPAccDefault;
  GPAccNull;
  GPAccNever;
}
class GPropAccessCtr extends Clazz{
  static public function unit(){
    return new GPropAccessCtr();
  }
  private function lift(self:GPropAccessSum):GPropAccess{
    return GPropAccess.lift(self);
  }
  public function Fn(){
    return GPAccFn; 
  }
  public function Default(){
    return GPAccDefault; 
  }
  public function Null(){
    return GPAccNull; 
  }
  public function Never(){
    return GPAccNever; 
  }
}
@:using(stx.g.lang.expr.GPropAccess.GPropAccessLift)
abstract GPropAccess(GPropAccessSum) from GPropAccessSum to GPropAccessSum{
  static public var __(default,never) = new GPropAccessCtr();
  public function new(self) this = self;
  @:noUsing static public function lift(self:GPropAccessSum):GPropAccess return new GPropAccess(self);

  public function prj():GPropAccessSum return this;
  private var self(get,never):GPropAccess;
  private function get_self():GPropAccess return lift(this);
}
class GPropAccessLift{
  static public function getting(self:GPropAccess){
    return switch(self){
      case GPAccFn       : 'get';
      case GPAccDefault  : 'default';
      case GPAccNull     : 'null';
      case GPAccNever    : 'never';
    }
  }
  static public function setting(self:GPropAccess){
    return switch(self){
      case GPAccFn       : 'set';
      case GPAccDefault  : 'default';
      case GPAccNull     : 'null';
      case GPAccNever    : 'never';
    }
  }
}