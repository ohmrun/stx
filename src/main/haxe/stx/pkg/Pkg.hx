package stx.pkg;

abstract Pkg(Block) from Block{
  public function new(self){
    this = self;
  }
  @:from static public function fromScope(p:Scope):Pkg{
    return new Pkg(
      Registry.instance.get(p)
    );
  }
  function source(){
    return Registry.instance.embed.unpack(this);
  }
  public function toString(){
    return Std.string(source());
  }
}
@:allow(stx.pkg) private class Registry{
  var embed     : Embed<Scope>;
  var register  : StringMap<Block>;

  public function new(){
    this.embed    = new Embed();
    this.register = new StringMap();
  }
  public function get(p:Scope){
    var key = p.identifier();
    if(!register.exists(key)){
      register.set(key,embed.pack(p));
    }
    return register.get(key);
  }
  static public var instance(default,null) : Registry = new Registry();
}