package stx.makro.type;

@:using(stx.makro.type.HFieldKind.HFieldKindLift)
abstract HFieldKind(StdFieldKind) from StdFieldKind to StdFieldKind{
  static public var _(default,never) = HFieldKindLift;
  public inline function new(self:StdFieldKind) this = self;
  static inline public function lift(self:StdFieldKind):HFieldKind return new HFieldKind(self);

  public function prj():StdFieldKind return this;
  private var self(get,never):HFieldKind;
  private function get_self():HFieldKind return lift(this);
}
class HFieldKindLift{
  static public inline function lift(self:StdFieldKind):HFieldKind{
    return HFieldKind.lift(self);
  }
  static public function is_method(self:HFieldKind){
    return switch(self){
      case FVar(read, write)  : false;
	    case FMethod(k)         : true;
    }
  }
  static public function is_var(self:HFieldKind){
    return switch(self){
      case FVar(read, write)  : true;
	    case FMethod(k)         : false;
    }
  }
}