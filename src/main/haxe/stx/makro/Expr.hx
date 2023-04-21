package stx.makro;

typedef Printer             = haxe.macro.Printer;

typedef HExpr                 = stx.makro.expr.HExpr;
typedef LiftHExpr             = stx.makro.expr.HExpr.LiftHExpr;
typedef HAccess               = stx.makro.expr.HAccess;

//typedef HTypePath             = stx.makro.expr.HTypePath;
typedef HTypeParam            = stx.makro.expr.HTypeParam;
typedef HComplexType          = stx.makro.expr.HComplexType;

typedef HExprCluster          = stx.makro.expr.HExprCluster;
typedef HExprClusterDef       = stx.makro.expr.HExprCluster.HExprClusterDef;

typedef HMethodCallDef        = stx.makro.expr.HMethodCall.HMethodCallDef; 
typedef HMethodCall           = stx.makro.expr.HMethodCall; 
typedef HExprDef              = stx.makro.expr.HExprDef;
typedef HFunction             = stx.makro.expr.HFunction;
typedef HFunctionArg          = stx.makro.expr.HFunctionArg;

typedef HConstant             = stx.makro.expr.HConstant;



typedef HMetadataEntry        = stx.makro.expr.HMetadataEntry;




typedef LiftConstantToHExpr        = stx.makro.expr.lift.LiftConstantToHExpr;
typedef LiftMethodRefToHExpr       = stx.makro.expr.lift.LiftMethodRefToHExpr;
typedef LiftModuleToHExpr          = stx.makro.expr.lift.LiftModuleToHExpr;

class Cases{
  static public function foldKeys<T>(m:Monoid<T>,c:Case):Continuation<T,HExpr>{
    return function(constructor:HExpr->T):T{
      var values = c.values.fold(
        (next:stx.makro.alias.StdExpr,memo) -> m.plus(constructor(HExpr.fromExpr(next)),memo),
        m.unit()
      );
      var guard  = c.guard == null ? m.unit() : constructor(HExpr.fromExpr(c.guard));

      var expr   = c.expr == null ? m.unit() : constructor(HExpr.fromExpr(c.expr));

      return m.plus(m.plus(values,guard),expr);
    } 
  }
}
class LiftMetadataEntry{
  static public function makro(md:StdMetadataEntry):MetadataEntry{
    return md;
  }
}
class LiftEBlock {
  #if macro
  static public function toEBlock(arr:Array<haxe.macro.Expr>):HExpr{
    return HExpr.fromExpr({
      expr  : StdExprDef.EBlock(arr.prj()),
      pos   : Context.currentPos()
    });
  }
  #end
}  