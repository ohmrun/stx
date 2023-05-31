package stx.makro.expr;

import haxe.macro.Expr.QuoteStatus as TQuoteStatus;

class HQuoteStatusCtr extends Clazz{
	public function Unquoted(){
		return HQuoteStatus.lift(TQuoteStatus.Unquoted);
	}
	public function Quoted(){
		return HQuoteStatus.lift(TQuoteStatus.Quoted);
	}
}
typedef HQuoteStatusDef = haxe.macro.Expr.QuoteStatus;

@:using(stx.makro.expr.HQuoteStatus.HQuoteStatusLift)
abstract HQuoteStatus(HQuoteStatusDef) from HQuoteStatusDef to HQuoteStatusDef{
	public function new(self) this = self;
	@:noUsing static public function lift(self:HQuoteStatusDef):HQuoteStatus return new HQuoteStatus(self);

	public function prj():HQuoteStatusDef return this;
	private var self(get,never):HQuoteStatus;
	private function get_self():HQuoteStatus return lift(this);
}
class HQuoteStatusLift{

}