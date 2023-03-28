package stx.makro.expr;

abstract HAccess(StdAccess) from StdAccess to StdAccess{
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