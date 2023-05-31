package stx.makro.expr;

final Expr = __.makro().expr;

class HTypeDefinitionCtr extends Clazz{
  public function Make(name,pack,kind:CTR<HTypeDefKindCtr,HTypeDefKind>,fields:CTR<HFieldCtr,Array<HField>>,?params:CTR<HTypeParamDeclCtr,Array<HTypeParamDecl>>,?meta:CTR<HMetadataEntryCtr,HMetadata>,?isExtern,?doc:Null<String>,?pos:CTR<HPositionCtr,HPosition>){
    return HTypeDefinition.make(
      Ident.make(name,pack),
      fields(Expr.HField).map(x -> x.prj()),
      kind(Expr.HTypeDefKind),
      isExtern,
      __.option(params).map(f -> f(Expr.HTypeParamDecl)).defv([]),
      __.option(meta).map(f -> f(Expr.HMetadataEntry)).defv([]),
      doc,
      __.option(pos).map(f -> f.apply(Expr.HPosition)).defv(new HPositionCtr().Make())
    );
  }
}
typedef HTypeDefinitionDef = StdTypeDefinition;
/**
  typedef TypeDefinition = {
    var pack                : Array<String>;
    var name                : String;
    var fields              : Array<Field>;
    var kind                : TypeDefKind;
    @:optional var isExtern : Bool;
    @:optional var params   : Array<TypeParamDecl>;
    @:optional var meta     : Metadata;
    @:optional var doc      : Null<String>;
    
    
    
    
    var pos                 : Position;
  	
  }
**/
@:forward abstract HTypeDefinition(StdTypeDefinition) from StdTypeDefinition to StdTypeDefinition{
  public function new(self){
    this = self;
  }
  @:noUsing static public function make(path:IdentDef,?fields:Array<HField>,?kind:TypeDefKind,?isExtern=false,?params:Array<HTypeParamDecl>,?meta:HMetadata,?doc:Null<String>,pos:haxe.macro.Expr.Position):HTypeDefinition{
    var out : StdTypeDefinition = {
      pack      : (cast path.pack:StdArray<String>),
      name      : path.name,
      fields    : __.option(fields).defv([]).map(x -> x.prj()).prj(),
      kind      : __.option(kind).defv(TDStructure),
      isExtern  : isExtern,
      params    : __.option(params).map(x -> x.prj()).defv([]),
      meta      : __.option(meta).map(x ->x.prj()).defv(null),
      doc       : doc,
      pos       : pos
    }
    return new HTypeDefinition(out);
  }
  public var kind(get,set) : TypeDefKind;

  public function set_kind(kind){
    return this.kind = kind;
  }
  public function get_kind(){
    return this.kind;
  }
}