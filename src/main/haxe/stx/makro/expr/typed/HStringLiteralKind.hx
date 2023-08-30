package stx.makro.expr.typed;

import haxe.macro.Expr.StringLiteralKind as TStringLiteralKind;

class HStringLiteralKindCtr extends Clazz{
	public function DoubleQuotes(){
		return HStringLiteralKind.lift(TStringLiteralKind.DoubleQuotes);
	}
	public function SingleQuotes(){
		return HStringLiteralKind.lift(TStringLiteralKind.SingleQuotes);
	}
}
typedef HStringLiteralKindDef = haxe.macro.Expr.StringLiteralKind;

@:using(stx.makro.expr.HStringLiteralKind.HStringLiteralKindLift)
abstract HStringLiteralKind(HStringLiteralKindDef) from HStringLiteralKindDef to HStringLiteralKindDef{
	public function new(self) this = self;
	@:noUsing static public function lift(self:HStringLiteralKindDef):HStringLiteralKind return new HStringLiteralKind(self);

	public function prj():HStringLiteralKindDef return this;
	private var self(get,never):HStringLiteralKind;
	private function get_self():HStringLiteralKind return lift(this);
}
class HStringLiteralKindLift{
}