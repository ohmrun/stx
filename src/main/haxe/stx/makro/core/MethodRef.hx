package stx.makro.core;

typedef MethodRefDef = {
  >ModuleDef,
  call : String,
}

@:forward abstract MethodRef(MethodRefDef) from MethodRefDef{
  public function new(self){
    this = self;
  }
  static public function fromModule(ident:Module,call:String):MethodRef{
    return {
      name    : ident.name,
      pack    : __.option(ident.pack).def(Way.unit),
      module  : ident.module,
      call    : call
    }
  }
  public function toModule():Module{
    return {
      name    : this.name,
      pack    : this.pack,
      module  : this.module
    };
  }
}