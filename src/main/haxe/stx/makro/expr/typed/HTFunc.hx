package stx.makro.expr.typed;

typedef HTFuncDef = haxe.macro.Type.TFunc;

@:using(stx.makro.expr.typed.HTFunc.HTFuncLift)
abstract HTFunc(HTFuncDef) from HTFuncDef to HTFuncDef{
  static public var _(default,never) = HTFuncLift;
  public inline function new(self:HTFuncDef) this = self;
  @:noUsing static inline public function lift(self:HTFuncDef):HTFunc return new HTFunc(self);

  public function prj():HTFuncDef return this;
  private var self(get,never):HTFunc;
  private function get_self():HTFunc return lift(this);
}
class HTFuncLift{
  static public inline function lift(self:HTFuncDef):HTFunc{
    return HTFunc.lift(self);
  }
}
/*
  typedef TFunc = {
    var args:Array<{v:TVar, value:Null<TypedExpr>}>;
    var t:Type;
    var expr:TypedExpr;
  }
*/