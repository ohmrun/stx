package eu.ohmrun.glot.expr;

class GMetadataEntryCtr extends Clazz{
  public function Make(name:String,?params:CTR<GExprCtr,Cluster<GExpr>>){
    return GMetadataEntry.lift({
      name    : name,
      params  : __.option(params).map(f -> f.apply(__.glot().Expr.GExpr)).defv([])
    });
  }
}
typedef GMetadataEntryDef = {
	var name:String;
	var ?params:Cluster<GExpr>;
}
@:using(eu.ohmrun.glot.expr.GMetadataEntry.GMetadataEntryLift)
@:forward abstract GMetadataEntry(GMetadataEntryDef) from GMetadataEntryDef to GMetadataEntryDef{
    public function new(self) this = self;
  @:noUsing static public function lift(self:GMetadataEntryDef):GMetadataEntry return new GMetadataEntry(self);
  public function prj():GMetadataEntryDef return this;
  private var self(get,never):GMetadataEntry;
  private function get_self():GMetadataEntry return lift(this);

  public function toSource():GSource{
		return Printer.ZERO.printMetadata(this);
	}
}
class GMetadataEntryLift{
  #if macro
  static public function to_macro_at(self:GMetadataEntry,pos:Position):MetadataEntry{
    return @:privateAccess {
      name    : self.name,
	    params  : __.option(self.params).map(x -> x.map(y -> y.to_macro_at(pos)).prj()).defv([]),
      pos     : pos
    };
  }
  #end
  // static public function denote(self:GMetadataEntry){
  //   final e = __.glot().expr();
  //   return e.Call(
  //     e.Path('eu.ohmrun.glot.expr.GMetadataEntry.GMetadataEntryCtr.Make'),
  //     [
  //       e.Constant(c -> c.String(self.name)),

  //     ]
  //   );
  // }
}