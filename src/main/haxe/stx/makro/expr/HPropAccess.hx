package stx.makro.expr;

class HPropAccessCtr extends Clazz{
  public function Fn():HPropAccess{
    return HPropAccess.lift(PAccFn);
  }
  public function Default():HPropAccess{
    return HPropAccess.lift(PAccDefault);
  }
  public function Null():HPropAccess{
    return HPropAccess.lift(PAccNull);
  }
  public function Never():HPropAccess{
    return HPropAccess.lift(PAccNever);
  }
}
enum abstract HPropAccessSum(String) from String{
  var PAccFn        = "get";
  var PAccDefault   = "default";
  var PAccNull      = "null";
  var PAccNever     = "never";

  public function toString():String{
    return this;
  }
}
@:using(stx.makro.expr.HPropAccess.HPropAccessLift)
@:forward abstract HPropAccess(HPropAccessSum) from HPropAccessSum to HPropAccessSum{
  static public var _(default,never) = HPropAccessLift;
  public inline function new(self:HPropAccessSum) this = self;
  @:noUsing static inline public function lift(self:HPropAccessSum):HPropAccess return new HPropAccess(self);

  public function prj():HPropAccessSum return this;
  private var self(get,never):HPropAccess;
  private function get_self():HPropAccess return lift(this);

  @:from static public function fromString(self:String):HPropAccess{
    return switch(self){
      case 'get'      : PAccFn;
      case 'default'  : PAccDefault;
      case 'null'     : PAccNull;
      case 'never'    : PAccNever;
      default          : throw 'unsupported HPropAcess "#${self}"';
    }
  }
  @:to public function toString():String{
    return this.toString();
  }
}
class HPropAccessLift{
  static public inline function lift(self:HPropAccessSum):HPropAccess{
    return HPropAccess.lift(self);
  }
}