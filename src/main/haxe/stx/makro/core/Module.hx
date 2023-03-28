package stx.makro.core;

@:using(stx.makro.core.Module.ModuleLift)
@:forward abstract Module(ModuleDef) from ModuleDef{
  static public var _(default,never) = ModuleLift;
  @:noUsing static public function lift(self:ModuleDef):Module{
    return new Module(self);
  }
  public function new(self:ModuleDef){
    this = self;
  }
  public function cons(str:String):Module{
    return stx.makro.core.Module.lift(switch([this.module,this.pack]){
      case [None,p] if(p.length == 0)         : { module : None, pack : Way.lift([str]), name : this.name};
      case [Some(md),p] if(p.length == 0)     : { module : Some(new haxe.io.Path('$str${__.sep()}$md')), pack : Way.unit() , name : this.name };
      case [None,arr]                         : { module : None, pack : Way.lift([str]).concat(arr), name : this.name};
      case [Some(md),arr]                     : { module : Some(new haxe.io.Path('$str${__.sep()}$md')), pack : Way.lift([str]).concat(arr) , name : this.name } ;
    });
  }
  public function call(str):MethodRef{
    return MethodRef.fromModule(this,str);
  }
  
  public function equals(that:ModuleDef){
    var thix = Ident.lift(this).toIdentifier();
    var thax = Ident.lift(that).toIdentifier();
    return thix == thax && this.module.zip(that.module).map(__.decouple((l,r) -> l == r )).defv(true);
  }
  public var module(get,never) : Option<haxe.io.Path>;
  private function get_module(){
    return __.option(this.module).flatten();
  } 
  @:from static public function fromIdentDef(self:IdentDef):Module{
    return new Module({ name : self.name, pack : self.pack, module : Option.unit() });
  }
  public function toString(){
    return _.toString(this);
  }
}
class ModuleLift{
  static public function toString(id:Module){
    return switch([id.module,id.pack]){
      case [None,pack] if (pack.length == 0)        : id.name;
      case [None,arr]                               : '${arr.join(".")}.${id.name}';
      case [Some(module),_]                         : '${module}.${id.name}';
    }
  }
  static public function toName(id:Module){
    return switch([id.module,id.pack]){
      case [None,arr] if(arr.length == 0)  : id.name;
      case [None,arr]                      : '${arr.join("_")}_${id.name}';
      case [Some(module),_]                : '${StringTools.replace(module.toString(),__.sep(),"_")}_${id.name}';
    }
  }
}