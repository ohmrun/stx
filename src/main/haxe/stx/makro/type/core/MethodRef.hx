package stx.makro.type.core;

typedef MethodRefDef = {
  >MonikerDef,
  call : String,
}

@:forward abstract MethodRef(MethodRefDef) from MethodRefDef{
  public function new(self){
    this = self;
  }
  static public function fromMoniker(ident:Moniker,call:String):MethodRef{
    return {
      name    : ident.name,
      pack    : __.option(ident.pack).def(Way.unit),
      module  : ident.module,
      call    : call
    }
  }
  public function toMoniker():Moniker{
    return {
      name    : this.name,
      pack    : this.pack,
      module  : this.module
    };
  }
  /**
   */
  public function canonical(){
    final under = Moniker.make(this.name,this.pack,this.module);
    return '${under.canonical()}.${this.call}';
  }
}