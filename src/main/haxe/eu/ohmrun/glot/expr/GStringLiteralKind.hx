package eu.ohmrun.glot.expr;

@:using(eu.ohmrun.glot.expr.GStringLiteralKind.GStringLiteralKindLift)
enum GStringLiteralKind {
	GDoubleQuotes;
	GSingleQuotes;
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