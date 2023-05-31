package eu.ohmrun.glot.expr;

class GAccessCtr extends Clazz{
	public function Public() 		return GAccess.lift(GAPublic);
	public function Private() 	return GAccess.lift(GAPrivate);
	public function Static() 		return GAccess.lift(GAStatic);
	public function Override() 	return GAccess.lift(GAOverride);
	public function Dynamic() 	return GAccess.lift(GADynamic);
	public function Inline() 		return GAccess.lift(GAInline);
	public function Macro() 		return GAccess.lift(GAMacro);
	public function Final() 		return GAccess.lift(GAFinal);
	public function Extern() 		return GAccess.lift(GAExtern);
	public function Abstract() 	return GAccess.lift(GAAbstract);
	public function Overload() 	return GAccess.lift(GAOverload);
}
enum GAccessSum {
	GAPublic;
	GAPrivate;
	GAStatic;
	GAOverride;
	GADynamic;
	GAInline;
	GAMacro;
	GAFinal;
	GAExtern;
	GAAbstract;
	GAOverload;
}
@:using(eu.ohmrun.glot.expr.GAccess.GAccessLift)
abstract GAccess(GAccessSum) from GAccessSum to GAccessSum{
  public function new(self) this = self;
  @:noUsing static public function lift(self:GAccessSum):GAccess return new GAccess(self);

  public function prj():GAccessSum return this;
  private var self(get,never):GAccess;
  private function get_self():GAccess return GAccess.lift(this);

	public function toSource():GSource{
		return Printer.ZERO.printAccess(this);
	}
}
class GAccessLift{
	#if macro

	static public function to_macro_at(self:GAccess,pos:Position):Access{
		return switch(self){
			case GAPrivate 			: APrivate;
			case GAPublic 			: APublic;
			case GAStatic  			: AStatic;
			case GAOverride			: AOverride;
			case GADynamic 			: ADynamic;
			case GAInline  			: AInline;
			case GAMacro   			: AMacro;
			case GAFinal   			: AFinal;
			case GAExtern  			: AExtern;
			case GAAbstract			: AAbstract;
			case GAOverload			: AOverload;
		}
	}
	#end
}