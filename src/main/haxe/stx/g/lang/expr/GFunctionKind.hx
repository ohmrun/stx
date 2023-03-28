package stx.g.lang.expr;

@:using(stx.g.lang.expr.GFunctionKind.GFunctionKindLift)
enum GFunctionKind{
	GFAnonymous;
	GFNamed(name:String, ?inlined:Bool);
	GFArrow;
}
class GFunctionKindLift{
	static public function to_macro_at(self:GFunctionKind,pos:Position):FunctionKind{
		return switch(self){
			case GFAnonymous           :		FAnonymous;
			case GFNamed(name, inlined):		FNamed(name, inlined);
			case GFArrow               :		FArrow;
		}
	}
}