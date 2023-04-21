package stx.makro.di;

import stx.makro.di.Util.*;

import haxe.macro.Expr;
import haxe.macro.Type;
import haxe.macro.Context;

class Injector{
  var di : DI;
  public function new(di){
    this.di = di;
  }
}