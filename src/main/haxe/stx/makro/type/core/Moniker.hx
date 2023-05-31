package stx.makro.type.core;

/**
 * Represents an identity including name, pack and module, but excluding type parameters
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
  public function cons(str:String):Moniker{
    return stx.makro.type.core.Moniker.lift(switch([this.module,this.pack]){
      case [None,p] if(p.length == 0)         : { module : None, pack : Way.lift([str]), name : this.name};
      case [Some(md),p] if(p.length == 0)     : { module : Some(new haxe.io.Path('$str${__.sep()}$md')), pack : Way.unit() , name : this.name };
      case [None,arr]                         : { module : None, pack : Way.lift([str]).concat(arr), name : this.name};
      case [Some(md),arr]                     : { module : Some(new haxe.io.Path('$str${__.sep()}$md')), pack : Way.lift([str]).concat(arr) , name : this.name } ;
    });
  }
  public function call(str):MethodRef{
    return MethodRef.fromMoniker(this,str);
  }
  
  public function equals(that:MonikerDef){
    var thix = Ident.lift(this).toIdentifier();
    var thax = Ident.lift(that).toIdentifier();
    return thix == thax && this.module.zip(that.module).map(__.decouple((l,r) -> l == r )).defv(true);
  }
  public var module(get,never) : Option<haxe.io.Path>;
  private function get_module(){
    return __.option(this.module).flatten();
  } 
  @:from static public function fromIdentDef(self:IdentDef):Moniker{
    return new Moniker({ name : self.name, pack : self.pack, module : Option.unit() });
  }
  public function canonical(){
    return _.canonical(this);
  }
}
class MonikerLift{
  static public function canonical(id:Moniker){
    return switch([id.module,id.pack]){
      case [None,pack] if (pack.length == 0)        : id.name;
      case [None,arr]                               : '${arr.join(".")}.${id.name}';
      case [Some(module),_]                         : '${module}.${id.name}';
    }
  }
  static public function toName(id:Moniker){
    return switch([id.module,id.pack]){
      case [None,arr] if(arr.length == 0)  : id.name;
      case [None,arr]                      : '${arr.join("_")}_${id.name}';
      case [Some(module),_]                : '${StringTools.replace(module.toString(),__.sep(),"_")}_${id.name}';
    }
  }
}