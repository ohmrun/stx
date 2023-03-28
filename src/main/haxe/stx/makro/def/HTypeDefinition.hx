package stx.makro.def;

/**
  typedef TypeDefinition = {
    var pack : Array<String>;
    var name : String;
    @:optional var doc : Null<String>;
    var pos : Position;
    @:optional var meta : Metadata;
    @:optional var params : Array<TypeParamDecl>;
    @:optional var isExtern : Bool;
    var kind : TypeDefKind;
  	var fields : Array<Field>;
  }
**/
@:forward abstract HTypeDefinition(StdTypeDefinition) from StdTypeDefinition to StdTypeDefinition{
  public function new(self){
    this = self;
  }
  @:noUsing static public function make(path:IdentDef,?fields:Cluster<HField>,?kind:TypeDefKind,pos:haxe.macro.Expr.Position):HTypeDefinition{
    var out : StdTypeDefinition = {
      name    : path.name,
      pack    : (cast path.pack:StdArray<String>),
      fields  : __.option(fields).defv([]).prj(),
      kind    : __.option(kind).defv(TDStructure),
      pos     : pos
    }
    return new HTypeDefinition(out);
  }
  var kind(get,set) : TypeDefKind;

  function set_kind(kind){
    return this.kind = kind;
  }
  function get_kind(){
    return this.kind;
  }
}