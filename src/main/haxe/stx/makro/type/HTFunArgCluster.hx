package stx.makro.type;

@:forward abstract HTFunArgCluster(Cluster<HTFunArg>) from Cluster<HTFunArg>{
  @:noUsing static public function lift(self:Cluster<HTFunArg>){
    return new HTFunArgCluster(self);
  }
  public function new(self) this = self;
  
  #if macro
  public function call(m:HMethodCall,pos):HExpr{
    return HExprDef.ECall(
      m.to_macro_at(pos),
      HExprCluster.unto((this.map(
        (param) -> param.getModule().toExpr()
      )))
    ).to_macro_at(pos);
  }
  #end
  @:from static public function fromArray(self:Array<HTFunArg>){
    return lift(Cluster.lift(self));
  }
} 