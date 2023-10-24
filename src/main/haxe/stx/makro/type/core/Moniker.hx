package stx.makro.type.core;

/**
 * Represents an identity including name, pack and module, but excluding type parameters
 * 
 * Note, `BaseType` doubles up the information between `pack` and `module` if the module is named
 * differently from the type. 
 */
@:using(stx.makro.type.core.Moniker.MonikerLift)
@:forward abstract Moniker(MonikerDef) from MonikerDef{
  static public var _(default,never) = MonikerLift;
  @:noUsing static public function lift(self:MonikerDef):Moniker{
    return new Moniker(self);
  }
  public function new(self:MonikerDef){
    this = self;
  }
  public function call(str):MethodRef{
    return MethodRef.fromMoniker(this,str);
  }
  public function equals(that:MonikerDef){
    var thix = Ident.lift(this).toIdentifier();
    var thax = Ident.lift(that).toIdentifier();
    return thix == thax && this.module.zip(that.module).map(__.decouple((l,r) -> l == r )).defv(true);
  }
  public var module(get,never) : Option<String>;
  private function get_module(){
    return __.option(this.module).flatten();
  } 
  static public function make(name,pack,module):Moniker{
    return new Moniker({ name : name, pack : pack, module : module });
  }
  public function canonical(){
    return _.canonical(this);
  }
  static public function fromBaseType(self:BaseType){
    final module = __.option(self.module).filter(x -> x!= "").flat_map(x -> x.split(".").last()).filter(
      x -> x != self.name
    );
    return make(self.name,self.pack,module);
  }
}
class MonikerLift{
  static public function canonical(id:Moniker){
    return switch([id.module,id.pack]){
      case [None,pack] if (pack.length == 0)            : id.name;
      case [None,pack]                                  : '${pack.join(".")}.${id.name}';
      case [Some(module),pack] if(pack.length == 0)     : '${module}.${id.name}';
      case [Some(module),pack]                          : '${pack.join(".")}.${module}.${id.name}';
    }
  }
  static public function to_name(id:Moniker){
    return switch([id.module,id.pack]){
      case [None,arr] if(arr.length == 0)  : id.name;
      case [None,arr]                      : '${arr.join("_")}_${id.name}';
      case [Some(module),_]                : '${StringTools.replace(module.toString(),__.sep(),"_")}_${id.name}';
    }
  }
  static public function get_path(self:Moniker):Cluster<String>{
    return switch([self.module,self.pack]){
      case [Some(x),ar] : ar.snoc(x);
      case [None,ar]    : ar;
    }
  }
}