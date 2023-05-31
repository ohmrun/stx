package eu.ohmrun.glot.expr;

class GFunctionKindCtr extends Clazz{
	public function Anonymous(){
		return GFunctionKind.lift(GFAnonymous);
	}
	public function Named(name:String,?inlined:Bool){
		return GFunctionKind.lift(GFNamed(name,inlined));
	}
	public function Arrow(){
		return GFunctionKind.lift(GFArrow);
	}
}
@:using(eu.ohmrun.glot.expr.GFunctionKind.GFunctionKindLift)
enum GFunctionKindSum{
	GFAnonymous;
	GFNamed(name:String, ?inlined:Bool);
	GFArrow;
}
@:using(eu.ohmrun.glot.expr.GFunctionKind.GFunctionKindLift)
abstract GFunctionKind(GFunctionKindSum) from GFunctionKindSum to GFunctionKindSum{
	public function new(self) this = self;
	static public var _(default,never) = GFunctionKindLift;
	@:noUsing static public function lift(self:GFunctionKindSum):GFunctionKind return new GFunctionKind(self);

	public function prj():GFunctionKindSum return this;
	private var self(get,never):GFunctionKind;
	private function get_self():GFunctionKind return lift(this);
}
class GFunctionKindLift{
	#if macro
	static public function to_macro_at(self:GFunctionKind,pos:Position):FunctionKind{
		return switch(self){
			case GFAnonymous           :		FAnonymous;
			case GFNamed(name, inlined):		FNamed(name, inlined);
			case GFArrow               :		FArrow;
		}
	}
	#end
}