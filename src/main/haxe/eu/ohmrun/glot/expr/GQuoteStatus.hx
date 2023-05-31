package eu.ohmrun.glot.expr;

class GQuoteStatusCtr extends Clazz{
	public function Unquoted(){
		return GQuoteStatus.lift(GUnquoted);
	}
	public function Quoted(){
		return GQuoteStatus.lift(GQuoted);
	}
}
@:using(eu.ohmrun.glot.expr.GQuoteStatus.GQuoteStatusLift)
enum GQuoteStatusSum {
	GUnquoted;
	GQuoted;
}
@:using(eu.ohmrun.glot.expr.GQuoteStatus.GQuoteStatusLift)
abstract GQuoteStatus(GQuoteStatusSum) from GQuoteStatusSum to GQuoteStatusSum{
	public function new(self) this = self;
	@:noUsing static public function lift(self:GQuoteStatusSum):GQuoteStatus return new GQuoteStatus(self);

	public function prj():GQuoteStatusSum return this;
	private var self(get,never):GQuoteStatus;
	private function get_self():GQuoteStatus return lift(this);
}
class GQuoteStatusLift{
	#if macro
	static public function to_macro_at(self:GQuoteStatus,pos:Position){
		return switch(self){
			case GUnquoted 	: Unquoted;
			case GQuoted 		: Quoted;
		}
	}
	#end
}