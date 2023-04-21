package stx.makro.def;

@:using(stx.makro.def.HPropAccess.HPropAccessLift)
enum HPropAccess{
  PAccFn;
  PAccDefault;
  PAccNull;
  PAccNever;
}
class HPropAccessLift{
  static public function getting(self:HPropAccess){
    return switch(self){
      case PAccFn       : 'get';
      case PAccDefault  : 'default';
      case PAccNull     : 'null';
      case PAccNever    : 'never';
    }
  }
  static public function setting(self:HPropAccess){
    return switch(self){
      case PAccFn       : 'set';
      case PAccDefault  : 'default';
      case PAccNull     : 'null';
      case PAccNever    : 'never';
    }
  }
}