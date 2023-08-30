package stx.makro.expr.type;

final __expr = __.makro().expr;

class AnonType extends Clazz{
  public function declare(self:StringMap<HExpr>):HExpr{
    final fields = 
      __expr.HExprdef.ObjectDecl(
        efield -> 
          self.toIterKV().toCluster().map(
          (f) -> 
            efield.Make(
              f.key,
              e -> f.value  
            )
          ).prj()
        );
    return __expr.HExpr.Make(e -> fields);
  }
} 