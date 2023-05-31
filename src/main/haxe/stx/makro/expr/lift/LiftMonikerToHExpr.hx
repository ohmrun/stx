package stx.makro.expr.lift;

class LiftMonikerToHExpr{
  static public function toHExpr(self:Moniker,pos){
    var id      = self;
    var efield  = HExprdef.EField;
    var ident   = Constant.CIdent.fn().then(x->stx.makro.expr.HExpr.LiftHExpr.Constant.toHExpr(x,pos));
    var head    = id.name;

    function f(next,memo) return efield(memo,next).to_macro_at(pos);

    return switch([id.module,id.pack]){
      case [None,pack] if(pack.length == 0)       : ident(head);
      case [None,arr]                             : 
        var arr = __.option(arr).def(Way.unit).snoc(head);
        arr.tail().lfold(f,ident(arr.head().def(()->"")));
      case [Some(dir),_]  : 
        var arr = dir.into(head).toArray();
        arr.tail().lfold(f,ident(arr.head().def(()->"")));
    };
  }
}