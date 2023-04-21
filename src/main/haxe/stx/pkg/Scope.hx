package stx.pkg;

@:forward abstract Scope(ScopeDef){
  public function new(self){
    this = self;
  }
  #if (!macro)
    @:from static public function fromPosInfos(pos:PosInfos):Scope{
      var module : Identifier  = Position.lift(pos).toIdentifier();
      var out : ScopeDef = {
        name : module.name,
        pack : Way.lift(module.pack)
      }
      return new Scope(out);
    }
  #end
    @:from static public function fromPosition(pos:Position):Scope{
      var module : Identifier  = pos.toPos().toIdentifier();
      var out : ScopeDef = {
        name : module.name,
        pack : Way.lift(module.pack)
      }
      return new Scope(out);
    }
  public function equals(that:Scope){
    var packl   = __.option(this.pack).def(Way.unit);
    var packr   = __.option(that.pack).def(Way.unit);
    var pack_ok = packl.length == packr.length;
    
    if(pack_ok){
      for (i in 0...packl.length){
        pack_ok = packl[i] == packr[i];
        if(!pack_ok){
          break;
        } 
      }
    }
    return this.name == that.name && pack_ok;
  }
  public function identifier(){
    return this.pack.length == 0 ? this.name : this.pack.snoc(this.name).join(".");
  }
}