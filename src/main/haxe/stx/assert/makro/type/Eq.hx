package stx.assert.makro.type;

import stx.assert.makro.type.eq.*;

class Eq extends Clazz{
  @:isVar public var HType(get,null):HType;
  private function get_HType():HType{
    return __.option(this.HType).def(() -> this.HType = new HType());
  }
  @:isVar public var HTypeParameter(get,null):HTypeParameter;
  private function get_HTypeParameter():HTypeParameter{
    return __.option(this.HTypeParameter).def(() -> this.HTypeParameter = new HTypeParameter());
  }
  @:isVar public var HClassField(get,null):HClassField;
  private function get_HClassField():HClassField{
    return __.option(this.HClassField).def(() -> this.HClassField = new HClassField());
  }
  @:isVar public var ClassField(get,null):stx.assert.makro.type.eq.ClassField;
  private function get_ClassField():stx.assert.makro.type.eq.ClassField{
    return __.option(this.ClassField).def(() -> this.ClassField = new stx.assert.makro.type.eq.ClassField());
  }
  @:isVar public var AnonStatus(get,null):stx.assert.makro.type.eq.AnonStatus;
  private function get_AnonStatus():stx.assert.makro.type.eq.AnonStatus{
    return __.option(this.AnonStatus).def(() -> this.AnonStatus = new stx.assert.makro.type.eq.AnonStatus());
  }
  @:isVar public var Type(get,null):stx.assert.makro.type.eq.Type;
  private function get_Type():stx.assert.makro.type.eq.Type{
    return __.option(this.Type).def(() -> this.Type = new stx.assert.makro.type.eq.Type());
  }
  @:isVar public var HVarAccess(get,null):HVarAccess;
  private function get_HVarAccess():HVarAccess{
    return __.option(this.HVarAccess).def(() -> this.HVarAccess = new HVarAccess());
  }
  @:isVar public var HMethodKind(get,null):HMethodKind;
  private function get_HMethodKind():HMethodKind{
    return __.option(this.HMethodKind).def(() -> this.HMethodKind = new HMethodKind());
  }
  @:isVar public var HEnumField(get,null):HEnumField;
  private function get_HEnumField():HEnumField{
    return __.option(this.HEnumField).def(() -> this.HEnumField = new HEnumField());
  }
  @:isVar public var HEnumType(get,null):HEnumType;
  private function get_HEnumType():HEnumType{
    return __.option(this.HEnumType).def(() -> this.HEnumType = new HEnumType());
  }
  @:isVar public var HFieldKind(get,null):HFieldKind;
  private function get_HFieldKind():HFieldKind{
    return __.option(this.HFieldKind).def(() -> this.HFieldKind = new HFieldKind());
  }
  @:isVar public var HBaseType(get,null):HBaseType;
  private function get_HBaseType():HBaseType{
    return __.option(this.HBaseType).def(() -> this.HBaseType = new HBaseType());
  }
  @:isVar public var HAbstractType(get,null):HAbstractType;
  private function get_HAbstractType():HAbstractType{
    return __.option(this.HAbstractType).def(() -> this.HAbstractType = new HAbstractType());
  }
  
  @:isVar public var HClassType(get,null):HClassType;
  private function get_HClassType():HClassType{
    return __.option(this.HClassType).def(() -> this.HClassType = new HClassType());
  }
  @:isVar public var HClassKind(get,null):HClassKind;
  private function get_HClassKind():HClassKind{
    return __.option(this.HClassKind).def(() -> this.HClassKind = new HClassKind());
  }
  public function HRef<T>(inner:stx.assert.Eq<T>):stx.assert.Eq<stx.makro.type.HRef<T>>{
    return new stx.assert.makro.type.eq.HRef(inner);
  }
  @:isVar public var HDefType(get,null):HDefType;
  private function get_HDefType():HDefType{
    return __.option(this.HDefType).def(() -> this.HDefType = new HDefType());
  }
  @:isVar public var HAnonType(get,null):HAnonType;
  private function get_HAnonType():HAnonType{
    return __.option(this.HAnonType).def(() -> this.HAnonType = new HAnonType());
  }
  
}
