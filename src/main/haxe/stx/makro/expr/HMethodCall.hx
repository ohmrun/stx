package stx.makro.expr;

typedef HMethodCallDef = {
  var data : MethodRef;
  var args : HExprCluster;
}
@:using(stx.makro.expr.HMethodCall.HMethodCallLift)
abstract HMethodCall(HMethodCallDef) from HMethodCallDef{
  public function new(self){
    this = self;
  }
  @:noUsing static public function pure(def:HMethodCallDef){
    return new HMethodCall(def);
  }
  @:noUsing static public function make(ref:MethodRef,args:HExprCluster):HMethodCall{
    return pure({
      data : ref,
      args : args
    });
  }
  public function prj(){
    return this;
  }
  
  public function to_macro_at(pos):HExpr{
    return HExprDef.ECall(
      stx.makro.expr.lift.LiftMethodRefToHExpr.toHExpr(this.data,pos),
      this.args
    ).to_macro_at(pos);
  }
}
class HMethodCallLift{
  
}