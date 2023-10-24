package stx.makro.type;

enum HTypeVariableSum{
  HTV_Applied();
  HTV_AppliedUnknown(t:Type);
  HTV_Unapplied;
}

@:using(stx.makro.type.HTypeVariable.HTypeVariableLift)
abstract HTypeVariable(HTypeVariableSum) from HTypeVariableSum to HTypeVariableSum{
  static public var _(default,never) = HTypeVariableLift;
  public inline function new(self:HTypeVariableSum) this = self;
  @:noUsing static inline public function lift(self:HTypeVariableSum):HTypeVariable return new HTypeVariable(self);

  public function prj():HTypeVariableSum return this;
  private var self(get,never):HTypeVariable;
  private function get_self():HTypeVariable return lift(this);
}
class HTypeVariableLift{
  static public inline function lift(self:HTypeVariableSum):HTypeVariable{
    return HTypeVariable.lift(self);
  }
}
