package stx.assert.makro.expr.eq;

import haxe.macro.Expr.StringLiteralKind as TStringLiteralKind;

final Eq = __.assert().Eq();

class StringLiteralKind extends EqCls<TStringLiteralKind>{

  public function new(){}

  public function comply(a:TStringLiteralKind,b:TStringLiteralKind):Equaled{
    return Eq.EnumValueIndex().comply(a,b);
  }
}