package stx.fail;

using eu.ohmrun.Pml;

enum PmlFailureSum{
  E_Pml(s:String);
  E_Pml_CannotMix<T>(l:PExpr<T>,r:PExpr<T>,?of:String);
  E_Pml_Nada;
  E_Pml_Empty;
  E_Pml_Parse(f:ParseFailure);
  E_Pml_Invalid(e:PExpr<Dynamic>);
  E_Pml_NoPApply(key:String);
}
abstract PmlFailure(PmlFailureSum) from PmlFailureSum to PmlFailureSum{
  public function new(self) this = self;
  static public function lift(self:PmlFailureSum):PmlFailure return new PmlFailure(self);

  public function prj():PmlFailureSum return this;
  private var self(get,never):PmlFailure;
  private function get_self():PmlFailure return lift(this);
}