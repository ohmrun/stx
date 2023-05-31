package eu.ohmrun.glot.expr;

final Expr = __.glot().Expr;

class GTypeDefinitionCtr extends Clazz{
  public function Make(name,pack,kind:CTR<GTypeDefKindCtr,GTypeDefKind>,fields:CTR<GEFieldCtr,Cluster<GEField>>,?params:CTR<GTypeParamDeclCtr,Cluster<GTypeParamDecl>>,?meta:CTR<GMetadataEntryCtr,GMetadata>,?isExtern,?doc:Null<String>){
    return GTypeDefinition.make(
      name,
      pack,
      kind(Expr.GTypeDefKind),
      fields(Expr.GEField),
      __.option(params).map(f -> f(Expr.GTypeParamDecl)).defv([]),
      __.option(meta).map(f -> f(Expr.GMetadataEntry)).defv(GMetadata.unit()),
      isExtern,
      doc
    );
  }
}
typedef GTypeDefinitionDef = {
  final name      : String;
	final pack      : Cluster<String>;
  final kind      : GTypeDefKind;
	final fields    : Cluster<GEField>;

	final ?params   : Cluster<GTypeParamDecl>;
	final ?meta     : GMetadata;
	final ?isExtern : Bool;
  final ?doc      : Null<String>;
}
@:using(eu.ohmrun.glot.expr.GTypeDefinition.GTypeDefinitionLift)
@:forward abstract GTypeDefinition(GTypeDefinitionDef) from GTypeDefinitionDef to GTypeDefinitionDef{
  static public var _(default,never) = GTypeDefinitionLift;
  public function new(self) this = self;
  @:noUsing static public function lift(self:GTypeDefinitionDef):GTypeDefinition return new GTypeDefinition(self);
  @:noUsing static public function make(name,pack,kind,fields,?params,?meta,?isExtern,?doc){
    return lift({
      name        : name,
      pack        : __.option(pack).defv([].imm()),
      kind        : kind,
      fields      : fields,
      params      : params,
      meta        : meta,
      isExtern    : isExtern,
      doc         : doc
    });
  }
  public function prj():GTypeDefinitionDef return this;
  private var self(get,never):GTypeDefinition;
  private function get_self():GTypeDefinition return lift(this);

  public function toSource():GSource{
		return Printer.ZERO.printTypeDefinition(this);
	}
  public function ident():Ident{
    return Ident.make(
      this.name,
      this.pack
    );
  }
  // public function get_enum_value_index(){
  //   return EnumValue.lift(this).index;
  // }
}
class GTypeDefinitionLift{
  #if macro
  static public function to_macro_at(self:GTypeDefinition,pos:Position):haxe.macro.Expr.TypeDefinition{
    __.log().debug('gtypedefinition.to_macro_at');
    return @:privateAccess {
      name        : self.name,
      pack        : self.pack.prj(),
      kind        : self.kind.to_macro_at(pos),
      fields      : self.fields.map(x -> x.to_macro_at(pos)).prj(),
      params      : __.option(self.params).map(x -> x.map(y -> y.to_macro_at(pos)).prj()).defv([]),
      meta        : __.option(self.meta).map( x -> x.to_macro_at(pos)).defv([]),
      isExtern    : self.isExtern,
      doc         : self.doc,
      pos         : pos
    }
  }
  #end
}