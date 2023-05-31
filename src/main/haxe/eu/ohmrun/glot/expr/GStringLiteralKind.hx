package eu.ohmrun.glot.expr;

class GStringLiteralKindCtr extends Clazz{
	public function DoubleQuotes(){
		return GStringLiteralKind.lift(GDoubleQuotes);
	}
	public function SingleQuotes(){
		return GStringLiteralKind.lift(GSingleQuotes);
	}
}
@:using(eu.ohmrun.glot.expr.GStringLiteralKind.GStringLiteralKindLift)
enum GStringLiteralKindSum {
	GDoubleQuotes;
	GSingleQuotes;
}
@:using(eu.ohmrun.glot.expr.GStringLiteralKind.GStringLiteralKindLift)
abstract GStringLiteralKind(GStringLiteralKindSum) from GStringLiteralKindSum to GStringLiteralKindSum{
	public function new(self) this = self;
	@:noUsing static public function lift(self:GStringLiteralKindSum):GStringLiteralKind return new GStringLiteralKind(self);

	public function prj():GStringLiteralKindSum return this;
	private var self(get,never):GStringLiteralKind;
	private function get_self():GStringLiteralKind return lift(this);
}
class GStringLiteralKindLift{
	#if macro
	
	static public function to_macro_at(self:GStringLiteralKind,pos:Position):StringLiteralKind{
		return switch(self){
			case GDoubleQuotes: DoubleQuotes;
			case GSingleQuotes: SingleQuotes;
		}
	}
	#end
	// static public function spell(self:GStringLiteralKind){
	// 	final e = __.glot().expr();
	// 	return e.Path(
	// 		switch(self){
	// 			case GDoubleQuotes : e.Path('eu.ohmrun.glot.expr.GStringLiteralKind.GDoubleQuotes');
	// 			case GSingleQuotes : e.Path('eu.ohmrun.glot.expr.GStringLiteralKind.GSingleQuotes');
	// 		}
	// 	);
	// }
}