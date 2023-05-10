package eu.ohmrun.glot.expr;

#if (haxe_ver > 4.205)
@:using(eu.ohmrun.glot.expr.GEFieldKind.GEFieldKindLift)
enum GEFieldKind {
	GNormal;
	GSafe;
}
class GEFieldKindLift{
	#if macro
	static public function to_macro_at(self:GEFieldKind,pos:Position){
		return switch(self){
			case GNormal 	: Normal;
			case GSafe 		: Safe;
		}
	}
	#end
}
#end