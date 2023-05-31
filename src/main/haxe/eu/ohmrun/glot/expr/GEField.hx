package eu.ohmrun.glot.expr;

final Expr = __.glot().Expr;

class GEFieldCtr extends Clazz{
  public function Make(name:String,kind:CTR<GFieldTypeCtr,GFieldType>,?access:CTR<GAccessCtr,Cluster<GAccess>>,?meta:CTR<GMetadataEntryCtr,GMetadata>,?doc){
    return eu.ohmrun.glot.expr.GEField.make(
      name,
      kind(Expr.GFieldType),
      __.option(access).map(f -> f(Expr.GAccess)).defv(null),
      __.option(meta).map(f -> f(Expr.GMetadataEntry)).defv(null),
      doc
    );
  }
}
typedef GEFieldDef = {
	final name     : String;
  final kind     : GFieldType;
	final ?access  : Cluster<GAccess>;
	final ?meta    : GMetadata;
  final ?doc     : Null<String>;
}
@:using(eu.ohmrun.glot.expr.GEField.GEFieldLift)
@:forward abstract GEField(GEFieldDef) from GEFieldDef to GEFieldDef{
    public function new(self) this = self;
  @:noUsing static public function lift(self:GEFieldDef):GEField return new GEField(self);
  @:noUsing static public function make(name:String,kind:GFieldType,?access,?meta,?doc){
    return lift({
      name    : name,
      kind    : kind,
      access  : access,
      meta    : meta,
      doc     : doc
    });
  }
  public function prj():GEFieldDef return this;
  private var self(get,never):GEField;
  private function get_self():GEField return lift(this);

  public function toSource():GSource{
		return Printer.ZERO.printField(this);
	}
}
class GEFieldLift{
  #if macro
  
  static public function to_macro_at(self:GEField,pos:Position):Field{
    return @:privateAccess {
      name      : self.name,
      kind      : self.kind.to_macro_at(pos),
      access    : __.option(self.access).map(x -> x.map(y -> y.to_macro_at(pos)).prj()).defv([]),
      meta      : __.option(self.meta).map(x -> x.to_macro_at(pos)).defv(null),
      doc       : self.doc,
      pos       : pos
    }
  }
  #end
}