package stx.assert.makro.expr.eq;

import haxe.macro.Expr.Position as TPosition;

final Eq = __.assert().Eq();

class Position extends EqCls<TPosition>{

  public function new(){}

  public function comply(a:TPosition,b:TPosition):Equaled{
    #if !macro
    var eq = Eq.String().comply(a.file,b.file);
    if(eq.is_equal()){
      eq = Eq.Int().comply(a.min,b.min);
    }
    if(eq.is_equal()){
      eq = Eq.Int().comply(a.max,b.max);
    }
    #else
    var eq = AreEqual;
    #end
    return eq;
  }
}