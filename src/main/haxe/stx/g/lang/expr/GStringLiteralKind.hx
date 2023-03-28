package stx.g.lang.expr;

@:using(stx.g.lang.expr.GStringLiteralKind.GStringLiteralKindLift)
enum GStringLiteralKind {
	GDoubleQuotes;
	GSingleQuotes;
}
class GStringLiteralKindLift{
	static public function to_macro_at(self:GStringLiteralKind,pos:Position):StringLiteralKind{
		return switch(self){
			case GDoubleQuotes: DoubleQuotes;
			case GSingleQuotes: SingleQuotes;
		}
	}
	// static public function spell(self:GStringLiteralKind){
	// 	final e = __.g().expr();
	// 	return e.Path(
	// 		switch(self){
	// 			case GDoubleQuotes : e.Path('stx.g.lang.expr.GStringLiteralKind.GDoubleQuotes');
	// 			case GSingleQuotes : e.Path('stx.g.lang.expr.GStringLiteralKind.GSingleQuotes');
	// 		}
	// 	);
	// }
}