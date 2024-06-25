package stx.makro.type;

import stx.makro.type.Identity.IdentityLift;

final _e = __.makro().expr;
final _t = __.makro().type;

class HModuleTypeCtr extends Clazz{
  public function TClassDecl(c:CTR<HClassTypeCtr,HClassType>){
  return TClassDecl(c.apply(_t.HClassType));
  }
  public function TEnumDecl(e:CTR<HEnumTypeCtr,HEnumType>){
    return TEnumDecl(e.apply(_t.HEnumType));
  }
  public function TTypeDecl(t:CTR<HDefTypeCtr,HDefType>){
    return TTypeDecl(t.apply(_t.HDefType));
  }
  public function TAbstract(a:CTR<HAbstractTypeCtr,HAbstractType>){
    return TAbstract(a.apply(_t.HAbstractType));
  }
}
@:using(stx.makro.type.HModuleType.HModuleTypeLift)
@:forward abstract HModuleType(StdModuleType) from StdModuleType to StdModuleType{
  
  public function new(self) this = self;
  
  public function getIdentity(){
    return IdentityLift.getMonikerIdentity(this);
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