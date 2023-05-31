package stx.makro.expr;

class HPositionCtr extends Clazz{
  public function Make(?pos:Position){
    pos = __.option(pos).def(
      () -> { 
        return 
          #if (display || neko || interp) 
            haxe.macro.Context.currentPos() 
          #else 
            null
          #end;
      }
    );
    return HPosition.lift(pos);
  }
}
typedef HPositionDef = haxe.macro.Expr.Position;

@:using(stx.makro.expr.HPosition.HPositionLift)
abstract HPosition(HPositionDef) from HPositionDef to HPositionDef{
  static public var _(default,never) = HPositionLift;
  public inline function new(self:HPositionDef) this = self;
  @:noUsing static inline public function lift(self:HPositionDef):HPosition return new HPosition(self);

  public function prj():HPositionDef return this;
  private var self(get,never):HPosition;
  private function get_self():HPosition return lift(this);
}
class HPositionLift{
  static public inline function lift(self:HPositionDef):HPosition{
    return HPosition.lift(self);
  }
}