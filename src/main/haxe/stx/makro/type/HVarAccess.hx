package stx.makro.type;

class HVarAccessCtr extends Clazz{
  public function Normal(){ return HVarAccess.lift(AccNormal);}
	public function No(){ return HVarAccess.lift(AccNo);}
	public function Never(){ return HVarAccess.lift(AccNever);}
	public function Resolve(){ return HVarAccess.lift(AccResolve);}
	public function Call(){ return HVarAccess.lift(AccCall);}
	public function Inline(){ return HVarAccess.lift(AccInline);}
	public function Require(r:String, ?msg:String){ return HVarAccess.lift(AccRequire(r, msg));}
	public function Ctor(){ return HVarAccess.lift(AccCtor);}
}

typedef HVarAccessDef = haxe.macro.Type.VarAccess;

@:using(stx.makro.type.HVarAccess.HVarAccessLift)
abstract HVarAccess(HVarAccessDef) from HVarAccessDef to HVarAccessDef{
  static public var _(default,never) = HVarAccessLift;
  public inline function new(self:HVarAccessDef) this = self;
  @:noUsing static inline public function lift(self:HVarAccessDef):HVarAccess return new HVarAccess(self);

  public function prj():HVarAccessDef return this;
  private var self(get,never):HVarAccess;
  private function get_self():HVarAccess return lift(this);
}
class HVarAccessLift{
  static public inline function lift(self:HVarAccessDef):HVarAccess{
    return HVarAccess.lift(self);
  }
}