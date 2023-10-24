package stx.makro.type;

final __type = __.makro().type;
final __expr = __.makro().expr;

class HAbstractTypeCtr extends Clazz{
  public function Make(
    pack,
    name,
    module,
    isPrivate,
    isExtern,
    params:CTR<HTypeParameterCtr,Cluster<HTypeParameter>>,
    type:CTR<HTypeCtr,HType>,
    binops:CTR<HAbstractTypeBinopCtr,Cluster<HAbstractTypeBinop>>,
    unops:CTR<HAbstractTypeUnopCtr,Cluster<HAbstractTypeUnop>>,
    from:CTR<HAbstractTypeCastCtr,Cluster<HAbstractTypeCast>>,
    to:CTR<HAbstractTypeCastCtr,Cluster<HAbstractTypeCast>>,
    array:CTR<HClassFieldCtr,Cluster<HClassField>>,
    resolve:Null<CTR<HClassFieldCtr,HClassField>>,
    resolveWrite:Null<CTR<HClassFieldCtr,HClassField>>,
    impl:Null<CTR<HRefCtr,HRef<HClassType>>>,
    meta:CTR<HMetaAccessCtr,HMetaAccess>,
    doc,
    exclude,
    pos:CTR<stx.makro.expr.HPosition.HPositionCtr,stx.makro.expr.HPosition>
  ){
    final resolve       = __.option(resolve).map(x -> x.apply(__type.HClassField)).defv(null);
    final resolveWrite  = __.option(resolveWrite).map(x -> x.apply(__type.HClassField)).defv(null);
    final impl          = __.option(impl).map(x -> x.apply(__type.HRef)).defv(null);

    return HAbstractType.make(
      pack,
      name,
      module,
      isPrivate,
      isExtern,
      params.apply(__type.HTypeParameter).prj(),
      type.apply(__type.HType),
      binops.apply(__type.HAbstractTypeBinop).prj(),
      unops.apply(__type.HAbstractTypeUnop).prj(),
      from.apply(__type.HAbstractTypeCast).prj(),
      to.apply(__type.HAbstractTypeCast).prj(),
      array.apply(__type.HClassField).prj(),
      resolve,
      resolveWrite,
      impl,
      meta.apply(__type.HMetaAccess).prj(),
      doc,
      exclude,
      pos.apply(__expr.HPosition)
    );
  }
}
@:using(stx.makro.type.HAbstractType.HAbstractTypeLift)
@:forward abstract HAbstractType(AbstractType) from AbstractType to AbstractType{
  static public var _(default,never) = HAbstractTypeLift;
  public function new(self) this = self;
  @:noUsing static public function lift(self:AbstractType):HAbstractType return new HAbstractType(self);
  @:noUsing static public function make(pack,name,module,isPrivate,isExtern,params,type,binops,unops,from,to,array,resolve,resolveWrite,impl,meta,doc,exclude,pos){
    return lift({
      pack          : pack,
      name          : name,
      module        : module,
      pos           : pos,
      isPrivate     : isPrivate,
      isExtern      : isExtern,
      params        : params,
      type          : type,
      binops        : binops,
      unops         : unops,
      from          : from,
      to            : to,
      array         : array,
      resolve       : resolve,
      resolveWrite  : resolveWrite,
      impl          : impl,
      meta : meta,
      doc : doc,
      exclude : exclude,
    });
  }
  public function prj():AbstractType return this;
  private var self(get,never):HAbstractType;
  private function get_self():HAbstractType return lift(this);
}
class HAbstractTypeLift{
  static public function getIdent(self:HAbstractType){
    return Ident.make(self.name,self.pack);
  } 
}