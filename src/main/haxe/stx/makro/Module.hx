package stx.makro;

class Module extends Clazz{
  @:isVar public var printer(get,null):haxe.macro.Printer;
  private function get_printer():haxe.macro.Printer{
    return __.option(this.printer).def(() -> this.printer = new haxe.macro.Printer());
  }

  #if (neko || eval || display)
  public function here(){
    return __.option(haxe.macro.Context.currentPos());
  }
  #else
  public function here(){
    return None;
  }
  #end
  @:isVar public var expr(get,null):stx.makro.expr.Module;
  private function get_expr():stx.makro.expr.Module{
    return __.option(this.expr).def(() -> this.expr = new stx.makro.expr.Module());
  }
  @:isVar public var type(get,null):stx.makro.type.Module;
  private function get_type():stx.makro.type.Module{
    return __.option(this.type).def(() -> this.type = new stx.makro.type.Module());
  }
}