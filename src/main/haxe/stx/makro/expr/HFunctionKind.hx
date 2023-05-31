package stx.makro.expr;

class HFunctionKindCtr extends Clazz{
	public function Anonymous(){
		return HFunctionKind.lift(FAnonymous);
	}
	public function Named(name:String,?inlined:Bool){
		return HFunctionKind.lift(FNamed(name,inlined));
	}
	public function Arrow(){
		return HFunctionKind.lift(FArrow);
	}
}

typedef HFunctionKindDef = haxe.macro.Expr.FunctionKind;

@:using(stx.makro.expr.HFunctionKind.HFunctionKindLift)
@:forward abstract HFunctionKind(HFunctionKindDef) from HFunctionKindDef to HFunctionKindDef{
  static public var _(default,never) = HFunctionKindLift;
  public inline function new(self:HFunctionKindDef) this = self;
  @:noUsing static inline public function lift(self:HFunctionKindDef):HFunctionKind return new HFunctionKind(self);

  public function prj():HFunctionKindDef return this;
  private var self(get,never):HFunctionKind;
  private function get_self():HFunctionKind return lift(this);
}
class HFunctionKindLift{
  static public inline function lift(self:HFunctionKindDef):HFunctionKind{
    return HFunctionKind.lift(self);
  }
} 