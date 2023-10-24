package stx.makro.type;

final _e = __.makro().expr;
final _t = __.makro().type;


class HDefTypeCtr extends Clazz{
  static public function Make(pack,
    name,
    module,
    type,
    isPrivate,
    isExtern,
    params:CTR<HTypeParameterCtr,Cluster<HTypeParameter>>,
    meta:CTR<HMetaAccessCtr,HMetaAccess>,
    doc,
    exclude,
    pos:CTR<stx.makro.expr.HPosition.HPositionCtr,stx.makro.expr.HPosition>
  ){
    return HDefType.make(
      pack,
      name,
      module,
      type.apply(_t.HType),
      isPrivate,
      isExtern,
      params.apply(_t.HTypeParameter).prj(),
      meta.apply(_t.HMetaAccess).prj(),
      doc,
      exclude,
      pos.apply(_e.HPosition)
    );
  }
}
@:using(stx.makro.type.HDefType.HDefTypeLift)
@:forward abstract HDefType(DefType) from DefType to DefType{
  static public var _(default,never) = HDefTypeLift;
  public inline function new(self:DefType) this = self;
  @:noUsing static inline public function lift(self:DefType):HDefType return new HDefType(self);

  @:noUsing static public function make(pack,name,module,type,isPrivate,isExtern,params,meta,doc,exclude,pos){
    return lift({
      pack      : pack,
      name      : name,
      type      : type,
      module    : module,
      pos       : pos,
      isPrivate : isPrivate,
      isExtern  : isExtern,
      params    : params,
      meta      : meta,
      doc       : doc,
      exclude   : exclude,
    });
  }

  public function prj():DefType return this;
  private var self(get,never):HDefType;
  private function get_self():HDefType return lift(this);
}
class HDefTypeLift{
  static public inline function lift(self:DefType):HDefType{
    return HDefType.lift(self);
  }
  static public function toBaseType(self:DefType):HBaseType{
    return HBaseType.lift(self);
  }
  static public function getIdent(self:DefType){
    return Ident.make(self.name,self.pack);
  }
}