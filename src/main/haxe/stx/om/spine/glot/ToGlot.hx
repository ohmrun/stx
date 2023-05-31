package stx.om.spine.glot;

final Expr = __.glot().Expr;

class ToGlot extends Clazz{
  public function apply(self:Spine){
    return switch(self){
      case Unknown        : Expr.GConstant.Ident('null').toGExpr();
      case Predate(v)     : Expr.GConstant.Ident('null').toGExpr();
      case Primate(sc)    : primitive_to_glot(sc).toGExpr();
      case Collect(arr)   : Expr.GExpr.ArrayDecl(arr.map((x) -> apply(x())));
      case Collate(arr)   : Expr.GExpr.ObjectDecl(
        _ -> arr.prj().map(x -> _.Make(x.fst(),apply(x.snd()())))
      );
    }
  }
  static function primitive_to_glot(self:Primitive){
    return switch(self){
      case PNull            : Expr.GConstant.Ident('null');
      case PBool(b)         : Expr.GConstant.Ident('$b');
      case PSprig(sprig)    : sprig_to_glot(sprig);
    }
  }
  static function sprig_to_glot(self:Sprig){
    return switch(self){
      case Textal(str)      : Expr.GConstant.String(str);
      case Byteal(byte)     : numeric_to_glot(byte);
    }
  }
  static function numeric_to_glot(self:Numeric){
    return switch(self){
      case NInt(int)    : Expr.GConstant.Int('$int');
      case NInt64(int)  : Expr.GConstant.Int('$int');//TODO is this supported?
      case NFloat(f)    : Expr.GConstant.Float('$f');
    }
  }
}