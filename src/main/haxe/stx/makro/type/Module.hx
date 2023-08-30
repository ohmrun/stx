package stx.makro.type;

class Module extends Clazz{
  @:isVar public var HRef(get,null):HRefCtr;
  private function get_HRef():HRefCtr{
    return __.option(this.HRef).def(() -> this.HRef = new HRefCtr());
  }
  @:isVar public var HType(get,null):HTypeCtr;
  private function get_HType():HTypeCtr{
    return __.option(this.HType).def(() -> this.HType = new HTypeCtr());
  }
  @:isVar public var HEnumType(get,null):HEnumTypeCtr;
  private function get_HEnumType():HEnumTypeCtr{
    return __.option(this.HEnumType).def(() -> this.HEnumType = new HEnumTypeCtr());
  }
  @:isVar public var HEnumField(get,null):HEnumFieldCtr;
  private function get_HEnumField():HEnumFieldCtr{
    return __.option(this.HEnumField).def(() -> this.HEnumField = new HEnumFieldCtr());
  }
  @:isVar public var HAbstractTypeUnop(get,null):HAbstractTypeUnopCtr;
  private function get_HAbstractTypeUnop():HAbstractTypeUnopCtr{
    return __.option(this.HAbstractTypeUnop).def(() -> this.HAbstractTypeUnop = new HAbstractTypeUnopCtr());
  }
  @:isVar public var HAbstractTypeBinop(get,null):HAbstractTypeBinopCtr;
  private function get_HAbstractTypeBinop():HAbstractTypeBinopCtr{
    return __.option(this.HAbstractTypeBinop).def(() -> this.HAbstractTypeBinop = new HAbstractTypeBinopCtr());
  }
  @:isVar public var HAbstractTypeCast(get,null):HAbstractTypeCastCtr;
  private function get_HAbstractTypeCast():HAbstractTypeCastCtr{
    return __.option(this.HAbstractTypeCast).def(() -> this.HAbstractTypeCast = new HAbstractTypeCastCtr());
  }
  @:isVar public var HAbstractType(get,null):HAbstractTypeCtr;
  private function get_HAbstractType():HAbstractTypeCtr{
    return __.option(this.HAbstractType).def(() -> this.HAbstractType = new HAbstractTypeCtr());
  }
  @:isVar public var HClassField(get,null):HClassFieldCtr;
  private function get_HClassField():HClassFieldCtr{
    return __.option(this.HClassField).def(() -> this.HClassField = new HClassFieldCtr());
  }
  @:isVar public var HTypeParameter(get,null):HTypeParameterCtr;
  private function get_HTypeParameter():HTypeParameterCtr{
    return __.option(this.HTypeParameter).def(() -> this.HTypeParameter = new HTypeParameterCtr());
  }
  @:isVar public var HMetaAccess(get,null):HMetaAccessCtr;
  private function get_HMetaAccess():HMetaAccessCtr{
    return __.option(this.HMetaAccess).def(() -> this.HMetaAccess = new HMetaAccessCtr());
  }
}