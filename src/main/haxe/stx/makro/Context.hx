package stx.makro;

class Context{
  #if (neko || eval || display)
  static public inline function here(wildcard:Wildcard){
    return haxe.macro.Context.currentPos();
  }
  #end
    /*
  static public macro function mtype(e:HExpr):HExprOf<Type>{
    var val = Context.typeof(e);
    var out = macro ${val};
    trace(out);
    return out;
  }*/
}