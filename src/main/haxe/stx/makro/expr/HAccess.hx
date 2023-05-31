package stx.makro.expr;

class HAccessCtr extends Clazz{
	public function Public() 		return HAccess.lift(APublic);
	public function Private() 	return HAccess.lift(APrivate);
	public function Static() 		return HAccess.lift(AStatic);
	public function Override() 	return HAccess.lift(AOverride);
	public function Dynamic() 	return HAccess.lift(ADynamic);
	public function Inline() 		return HAccess.lift(AInline);
	public function Macro() 		return HAccess.lift(AMacro);
	public function Final() 		return HAccess.lift(AFinal);
	public function Extern() 		return HAccess.lift(AExtern);
	public function Abstract() 	return HAccess.lift(AAbstract);
	public function Overload() 	return HAccess.lift(AOverload);
}
typedef HAccessDef = StdAccess;

@:forward abstract HAccess(StdAccess) from StdAccess to StdAccess{
  public function new(self) this = self;
  @:noUsing static public function lift(self:StdAccess):HAccess return new HAccess(self);

  public function prj():StdAccess return this;
  private var self(get,never):HAccess;
  private function get_self():HAccess return lift(this);

  static public function Public():HAccess return lift(StdAccess.APublic);
  static public function Private():HAccess return lift(StdAccess.APrivate);
  static public function Static():HAccess return lift(StdAccess.AStatic);
  static public function Override():HAccess return lift(StdAccess.AOverride);
  static public function Dynamic():HAccess return lift(StdAccess.ADynamic);
  static public function Inline():HAccess return lift(StdAccess.AInline);
  static public function Macro():HAccess return lift(StdAccess.AMacro);
  static public function Final():HAccess return lift(StdAccess.AFinal);
  static public function Extern():HAccess return lift(StdAccess.AExtern);
  static public function Abstract():HAccess return lift(StdAccess.AAbstract);
  static public function Overload():HAccess return lift(StdAccess.AOverload);  
}