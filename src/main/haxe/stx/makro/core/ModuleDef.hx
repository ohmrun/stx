package stx.makro.core;

typedef ModuleDef = IdentDef & {
  @:optional var module : Option<haxe.io.Path>;
}