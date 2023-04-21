package stx.makro.type;

@:using(stx.makro.type.HModuleType.HModuleTypeLift)
@:forward abstract HModuleType(StdModuleType) from StdModuleType{
  static public var _(default,never) = HModuleTypeLift;
  public function new(self) this = self;
  
  public function getIdentity(){
    return Identity._.getModuleIdentity(this);
  }
}
class HModuleTypeLift{
  static public function getMeta(type:HModuleType){
    return getBaseType(type).meta.get();
  }
  static public function getBaseType(type:HModuleType):BaseType{
    return switch(type){
      case TClassDecl(c)  : c.get();
      case TEnumDecl(e)   : e.get();
      case TTypeDecl(t)   : t.get();
	    case TAbstract(a)   : a.get();
    }
  }
}