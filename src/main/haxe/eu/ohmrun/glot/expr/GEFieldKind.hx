package eu.ohmrun.glot.expr;

#if (haxe_ver > 4.205)
class GEFieldKindCtr extends Clazz{
	public function Normal(){
		return GEFieldKind.lift(GNormal);
	}
	public function Safe(){
		return GEFieldKind.lift(GSafe);
	}
}

@:using(eu.ohmrun.glot.expr.GEFieldKind.GEFieldKindLift)
enum GEFieldKindSum {
	GNormal;
	GSafe;
}
@:using(eu.ohmrun.glot.expr.GEFieldKind.GEFieldKindLift)
abstract GEFieldKind(GEFieldKindSum) from GEFieldKindSum to GEFieldKindSum{
	public function new(self) this = self;
	@:noUsing static public function lift(self:GEFieldKindSum):GEFieldKind return new GEFieldKind(self);

	public function prj():GEFieldKindSum return this;
	private var self(get,never):GEFieldKind;
	private function get_self():GEFieldKind return lift(this);
}
class GEFieldKindLift{
	#if macro
	static public function to_macro_at(self:GEFieldKind,pos:Position):EFieldKind{
		return switch(self){
			case GNormal 	: EFieldKind.Normal;
			case GSafe 		: EFieldKind.Safe;
		}
	}
	#end
}
#end