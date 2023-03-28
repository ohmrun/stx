package stx;

using stx.Pico;
using stx.Nano;
using eu.ohmrun.Fletcher;
using stx.config.Logging;
using stx.Io;

typedef ConfigFailure           = stx.fail.ConfigFailure;
typedef ConfigFailureSum        = stx.fail.ConfigFailure.ConfigFailureSum;
typedef ConfigurationDef<C>     = Provide<C>;

class Configure{
  static public function config(wildcard:Wildcard){
    return new stx.config.core.Module();
  }
}