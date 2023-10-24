package stx.makro.expr;

typedef HExprArrayDef = Array<HExpr>;

@:forward abstract HExprArray(HExprArrayDef) from HExprArrayDef{
  public function new(self) this = self;
  @:noUsing static public function lift(self:HExprArrayDef):HExprArray return new HExprArray(self);
  static public function unto(self:Array<Expr>):HExprArray{
    return lift(self.map(HExpr.fromExpr));
  }

  public function toExprArray():Array<Expr>{
    return this.map(x -> x.toExpr()).prj();
  } 

  public function prj():HExprArrayDef return this;
  private var self(get,never):HExprArray;
  private function get_self():HExprArray return lift(this);

  @:from static public function fromCluster(self:Cluster<HExpr>){
    return lift(self.prj());
  }
}