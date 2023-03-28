package stx.makro.expr;

@:using(stx.makro.expr.HTypeParamDecl.HTypeParamDeclLift)
abstract HTypeParamDecl(StdTypeParamDecl) from StdTypeParamDecl to StdTypeParamDecl{
  static public var _(default,never) = HTypeParamDeclLift;
  public function new(self) this = self;
  @:noUsing static public function lift(self:StdTypeParamDecl):HTypeParamDecl return new HTypeParamDecl(self);

  public function prj():StdTypeParamDecl return this;
  private var self(get,never):HTypeParamDecl;
  private function get_self():HTypeParamDecl return lift(this);
}
class HTypeParamDeclLift{
  @:noUsing static public function lift(self:StdTypeParamDecl){
    return TypeParamDecl.lift(self);
  }

}