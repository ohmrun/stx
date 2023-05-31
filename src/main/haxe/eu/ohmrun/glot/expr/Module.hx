package eu.ohmrun.glot.expr;

class Module extends Clazz{
  @:isVar public var GTypeDefinition(get,null):GTypeDefinitionCtr;
  private function get_GTypeDefinition():GTypeDefinitionCtr{
    return __.option(this.GTypeDefinition).def(() -> this.GTypeDefinition = new GTypeDefinitionCtr());
  }
  @:isVar public var GEField(get,null):GEFieldCtr;
  private function get_GEField():GEFieldCtr{
    return __.option(this.GEField).def(() -> this.GEField = new GEFieldCtr());
  }
  @:isVar public var GFieldType(get,null):GFieldTypeCtr;
  private function get_GFieldType():GFieldTypeCtr{
    return __.option(this.GFieldType).def(() -> this.GFieldType = new GFieldTypeCtr());
  }
  @:isVar public var GFunctionArg(get,null):GFunctionArgCtr;
  private function get_GFunctionArg():GFunctionArgCtr{
    return __.option(this.GFunctionArg).def(() -> this.GFunctionArg = new GFunctionArgCtr());
  }
  @:isVar public var GComplexType(get,null):GComplexTypeCtr;
  private function get_GComplexType():GComplexTypeCtr{
    return __.option(this.GComplexType).def(() -> this.GComplexType = new GComplexTypeCtr());
  }
  @:isVar public var GExpr(get,null):GExprCtr;
  private function get_GExpr():GExprCtr{
    return __.option(this.GExpr).def(() -> this.GExpr = new GExprCtr());
  }
  @:isVar public var GConstant(get,null):GConstantCtr;
  private function get_GConstant():GConstantCtr{
    return __.option(this.GConstant).def(() -> this.GConstant = new GConstantCtr());
  }
  @:isVar public var GTypePath(get,null):GTypePathCtr;
  private function get_GTypePath():GTypePathCtr{
    return __.option(this.GTypePath).def(() -> this.GTypePath = new GTypePathCtr());
  }
  @:isVar public var GFunction(get,null):GFunctionCtr;
  private function get_GFunction():GFunctionCtr{
    return __.option(this.GFunction).def(() -> this.GFunction = new GFunctionCtr());
  }
  @:isVar public var GObjectField(get,null):GObjectFieldCtr;
  private function get_GObjectField():GObjectFieldCtr{
    return __.option(this.GObjectField).def(() -> this.GObjectField = new GObjectFieldCtr());
  }
  @:isVar public var GTypeParam(get,null):GTypeParamCtr;
  private function get_GTypeParam():GTypeParamCtr{
    return __.option(this.GTypeParam).def(() -> this.GTypeParam = new GTypeParamCtr());
  }
  @:isVar public var GCase(get,null):GCaseCtr;
  private function get_GCase():GCaseCtr{
    return __.option(this.GCase).def(() -> this.GCase = new GCaseCtr());
  }
  @:isVar public var GCatch(get,null):GCatchCtr;
  private function get_GCatch():GCatchCtr{
    return __.option(this.GCatch).def(() -> this.GCatch = new GCatchCtr());
  }
  @:isVar public var GMetadataEntry(get,null):GMetadataEntryCtr;
  private function get_GMetadataEntry():GMetadataEntryCtr{
    return __.option(this.GMetadataEntry).def(() -> this.GMetadataEntry = new GMetadataEntryCtr());
  }
  @:isVar public var GVar(get,null):GVarCtr;
  private function get_GVar():GVarCtr{
    return __.option(this.GVar).def(() -> this.GVar = new GVarCtr());
  }
  @:isVar public var GPropAccess(get,null):GPropAccessCtr;
  private function get_GPropAccess():GPropAccessCtr{
    return __.option(this.GPropAccess).def(() -> this.GPropAccess = new GPropAccessCtr());
  }
  @:isVar public var GTypeParamDecl(get,null):GTypeParamDeclCtr;
  private function get_GTypeParamDecl():GTypeParamDeclCtr{
    return __.option(this.GTypeParamDecl).def(() -> this.GTypeParamDecl = new GTypeParamDeclCtr());
  }
  @:isVar public var GAccess(get,null):GAccessCtr;
  private function get_GAccess():GAccessCtr{
    return __.option(this.GAccess).def(() -> this.GAccess = new GAccessCtr());
  }
  @:isVar public var GTypeDefKind(get,null):GTypeDefKindCtr;
  private function get_GTypeDefKind():GTypeDefKindCtr{
    return __.option(this.GTypeDefKind).def(() -> this.GTypeDefKind = new GTypeDefKindCtr());
  }
}
