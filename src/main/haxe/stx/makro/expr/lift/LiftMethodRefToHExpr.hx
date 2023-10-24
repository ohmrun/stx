package stx.makro.expr.lift;

class LiftMethodRefToHExpr{
  static public function toHExpr(self:MethodRef,pos:Position){ 
    var ref     = self;
    var efield  = HExprdef.EField;
    var ident   = Constant.CIdent.fn().then(c -> stx.makro.expr.HExpr.LiftHExpr.Constant.toHExpr(c,pos));
    var head    = ref.call;
    function f(next,memo) return efield(memo,next).to_macro_at(pos);

    final parts = (self:MethodRef).toMoniker().canonical().split(".");
    return parts.ldropn(1).lfold(f,ident(parts.head().fudge()));
  }
}