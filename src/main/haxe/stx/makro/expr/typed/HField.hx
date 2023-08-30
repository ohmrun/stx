package stx.makro.expr.typed;

final Expr = __.makro().expr;

class HFieldCtr extends Clazz{
  public function make(name:String,kind:CTR<HFieldTypeCtr,HFieldType>,?access:CTR<HAccessCtr,Array<HAccess>>,?doc:String,?meta:CTR<HMetadataCtr,HMetadata>,?pos:CTR<HPositionCtr,HPosition>){
    final access  = __.option(access).map(x -> x.apply(Expr.HAccess)).defv(null);
    final pos     = __.option(pos).map(x -> x.apply(Expr.HPosition)).defv(null);
    final meta    = __.option(meta).map(x -> x.apply(Expr.HMetadata)).defv(null);
    return HField.make(name,kind.apply(Expr.HFieldType),access,doc,meta,pos);
  }
}
typedef HFieldDef = StdField;

@:using(stx.makro.expr.HField.HFieldLift)
@:forward abstract HField(StdField) from StdField to StdField{
  static public var _(default,never) = HFieldLift;
  public inline function new(self:StdField) this = self;
  static inline public function lift(self:StdField):HField return new HField(self);

  static inline public function make(name:String,kind:HFieldType,?access,?doc,?meta,pos:HPosition){
    return lift({
      name      : name,
      kind      : kind,
      pos       : pos,
      access    : access,
      doc       : doc,
      meta      : meta
    });
  }
  public function prj():StdField return this;
  private var self(get,never):HField;
  private function get_self():HField return lift(this);

}
class HFieldLift{
  static public inline function lift(self:StdField):HField{
    return HField.lift(self);
  }
}