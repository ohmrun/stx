package stx.makro.expr;

typedef HExprClusterDef = Cluster<HExpr>;

@:forward abstract HExprCluster(HExprClusterDef) from HExprClusterDef{
  public function new(self) this = self;
  @:noUsing static public function lift(self:HExprClusterDef):HExprCluster return new HExprCluster(self);
  static public function unto(self:Cluster<StdExpr>):HExprCluster{
    return lift(self.map(HExpr.fromExpr));
  }

  public function toExprArray():Array<Expr>{
    return this.map(x -> x.toExpr()).prj();
  } 

  public function prj():HExprClusterDef return this;
  private var self(get,never):HExprCluster;
  private function get_self():HExprCluster return lift(this);
}