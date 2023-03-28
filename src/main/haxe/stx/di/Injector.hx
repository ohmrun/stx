package stx.di;

import stx.di.Util.*;

import haxe.macro.Expr;
import haxe.macro.Type;
import haxe.macro.Context;

class Injector{
  var di : DI;
  public function new(di){
    this.di = di;
  }
}