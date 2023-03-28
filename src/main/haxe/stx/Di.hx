package stx;

typedef Assembly = stx.di.Assembly;

class Di{
  @:noUsing static public macro function derive(e:haxe.macro.Expr){
    return stx.di.Injectors.run(e);
  }
}