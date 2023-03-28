package stx.di.test;

import haxe.macro.Expr;

class Regression{
  public function new(){

  }
  macro public function toot(self:Expr):Expr {
    return macro { trace("toot"); }
  }
  public function scoot(){

  }
}