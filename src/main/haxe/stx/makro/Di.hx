package stx.makro;

typedef Assembly = stx.makro.di.core.Assembly;

class Di{
  @:noUsing static public macro function derive(e:haxe.macro.Expr){
    return stx.makro.di.Injectors.run(e);
  }
}