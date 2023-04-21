package stx.g.lang.expr;

class GMetadataEntryCtr extends Clazz{
  static public function unit(){
    return new GMetadataEntryCtr();
  }
  private function lift(self:GMetadataEntryDef):GMetadataEntry{
    return GMetadataEntry.lift(self);
  }
  public function Make(name:String,?params:CTR<GExprCtr,Cluster<GExpr>>){
    return lift({
      name    : name,
      params  : __.option(params).map(f -> f(GExprCtr.unit())).defv([])
    });
  }
}
typedef GMetadataEntryDef = {
	var name:String;
	var ?params:Cluster<GExpr>;
}
@:using(stx.g.lang.expr.GMetadataEntry.GMetadataEntryLift)
@:forward abstract GMetadataEntry(GMetadataEntryDef) from GMetadataEntryDef to GMetadataEntryDef{
  static public var __(default,never) = new GMetadataEntryCtr();
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
  static public function to_macro_at(self:GMetadataEntry,pos:Position):MetadataEntry{
    return {
      name    : self.name,
	    params  : __.option(self.params).map(x -> x.map(y -> y.to_macro_at(pos)).prj()).defv([]),
      pos     : pos
    };
  }
  // static public function denote(self:GMetadataEntry){
  //   final e = __.g().expr();
  //   return e.Call(
  //     e.Path('stx.g.lang.expr.GMetadataEntry.GMetadataEntryCtr.Make'),
  //     [
  //       e.Constant(c -> c.String(self.name)),

  //     ]
  //   );
  // }
}