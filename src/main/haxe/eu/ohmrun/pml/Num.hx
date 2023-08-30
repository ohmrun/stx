package eu.ohmrun.pml;

enum NumSum{
  NInt(int:Int);
  NFloat(fl:Float);
}

@:using(eu.ohmrun.pml.Num.NumLift)
abstract Num(NumSum) from NumSum to NumSum{
  static public var _(default,never) = NumLift;
  public inline function new(self:NumSum) this = self;
  @:noUsing static inline public function lift(self:NumSum):Num return new Num(self);

  public function prj():NumSum return this;
  private var self(get,never):Num;
  private function get_self():Num return lift(this);

  public function toString(){
    return switch(this){
      case NFloat(fl) : '$fl';
      case NInt(int)  : '$int';
    }
  }
}
class NumLift{
  static public inline function lift(self:NumSum):Num{
    return Num.lift(self);
  }
}
