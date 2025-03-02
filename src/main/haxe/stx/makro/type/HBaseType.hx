package stx.makro.type;

final __type = __.makro().type;
final __expr = __.makro().expr;

class HBaseTypeCtr extends Clazz{
  public function Make(
    pack,
    name,
    module,
    isPrivate,
    isExtern,
    params:CTR<HTypeParameterCtr,Cluster<HTypeParameter>>,
    meta:CTR<HMetaAccessCtr,HMetaAccess>,
    doc,
    exclude,
    pos:CTR<stx.makro.expr.HPosition.HPositionCtr,stx.makro.expr.HPosition>
  ){
    return HBaseType.make(
      pack,
      name,
      module,
      isPrivate,
      isExtern,
      params.apply(__type.HTypeParameter).prj(),
      meta.apply(__type.HMetaAccess).prj(),
      doc,
      exclude,
      pos.apply(__expr.HPosition)
    );
  }
}
@:using(stx.makro.type.HBaseType.HBaseTypeLift)
@:forward abstract HBaseType(StdBaseType) from StdBaseType to StdBaseType{
  
  @:noUsing static public function lift(self:StdBaseType){
    return new HBaseType(self);
  }
  @:noUsing static public function make(pack,name,module,isPrivate,isExtern,params,meta,doc,exclude,pos){
    return lift({
      pack      : pack,
      name      : name,
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
  public function new(self){
    this = self;
  }
}
class HBaseTypeLift{
  static public function getParamTypes(b:BaseType):Array<Type>{
    return b.params.map((tp)->tp.t);
  }
  static public function getMoniker(b:BaseType):Moniker{
    return Moniker.fromBaseType(b);
  }
  static public function hasPack(b:BaseType):Bool{
    return b.pack != null && b.pack.length > 0;
  }
  /**
    Returns false if the type is found in a module with a name different to the module.
  */
  static public function is_module_name_consistent(b:BaseType){
    var module_els = b.module.split(".");
    var out        = module_els[module_els.length-1] == b.name;
    return out;
  }
  static public function copy(self:HBaseType,
    ?pack:Array<String>,
    ?name:String,
    ?module:String,
    ?pos:haxe.macro.Expr.Position,
    ?isPrivate:Bool,
    ?isExtern:Bool,
    ?params:Array<TypeParameter>,
    ?meta:MetaAccess,
    ?doc:Null<String>,
    ?exclude:()->Void
  ){
    return {
      pack        : __.option(pack).def(() -> self.pack),
      name        : __.option(name).def(() -> self.name),
      module      : __.option(module).def(() -> self.module),
      pos         : __.option(pos).def(() -> self.pos),
      isPrivate   : __.option(isPrivate).def(() -> self.isPrivate),
      isExtern    : __.option(isExtern).def(() -> self.isExtern),
      params      : __.option(params).def(() -> self.params),
      meta        : __.option(meta).def(() -> self.meta),
      doc         : __.option(doc).def(() -> self.doc),
      exclude     : __.option(exclude).def(() -> self.exclude)
    }
  }
}