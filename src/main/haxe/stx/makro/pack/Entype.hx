package stx.makro.pack;

import stx.makro.Expr;

@:keep class Entype{
  @:noUsing static public function apply(expr:HExpr):HExpr{
    return switch(expr.expr){
      case EParenthesis({ expr :  ECheckType({ expr : EConst(CIdent("_")), pos : _ }, ct ), pos : _ }) :
          macro function(x:Dynamic):$ct { return (x:$ct); }
      default : throw "entype requires form (_:$type), and produces a function Dynamic -> $type.";
    }
  }
}
