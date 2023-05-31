package eu.ohmrun.glot;

class Module extends Clazz{
  #if macro
  public function to_macro_at(){
    return new GExprCtr();
  }  
  #end
  @:isVar public var Expr(get,null):eu.ohmrun.glot.expr.Module;
  private function get_Expr():eu.ohmrun.glot.expr.Module{
    return __.option(this.Expr).def(() -> this.Expr = new eu.ohmrun.glot.expr.Module());
  } 
}