package stx.makro.type.core;

/**
 * Represents an identity including name, pack and module, but excluding type parameters
 */
typedef MonikerDef = IdentDef & {
  @:optional var module : Option<String>;
}