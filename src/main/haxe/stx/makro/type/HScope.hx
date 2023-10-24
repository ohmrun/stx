package stx.makro.type;

class HScopeCls{
  public final type   : HType;
  public final index  : Int;
  
  public function new(type:HType,index = 0){
    this.type   = type;
    this.index  = index;
  }
}

@:using(stx.makro.type.HScope.HScopeLift)
abstract HScope(HScopeCls) from HScopeCls to HScopeCls{
  static public var _(default,never) = HScopeLift;
  public inline function new(self:HScopeCls) this = self;
  @:noUsing static inline public function lift(self:HScopeCls):HScope return new HScope(self);
  @:noUsing static inline public function make(type:HType,?index:Int):HScope return new HScope(new HScopeCls(type,index));

  public function prj():HScopeCls return this;
  private var self(get,never):HScope;
  private function get_self():HScope return lift(this);
}
class HScopeLift{
  static public inline function lift(self:HScopeCls):HScope{
    return HScope.lift(self);
  }
}

