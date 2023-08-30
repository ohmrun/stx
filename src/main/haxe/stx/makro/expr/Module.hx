package stx.makro.expr;

class Module extends Clazz{
  @:isVar public var type(get,null):stx.makro.expr.type.Module;
  private function get_type():stx.makro.expr.type.Module{
    return __.option(this.type).def(() -> this.type = new stx.makro.expr.type.Module());
  }
  @:isVar public var HExpr(get,null):HExprCtr;
  private function get_HExpr():HExprCtr{
    return __.option(this.HExpr).def(() -> this.HExpr = new HExprCtr());
  }
  @:isVar public var HTypeDefinition(get,null):HTypeDefinitionCtr;
  private function get_HTypeDefinition():HTypeDefinitionCtr{
    return __.option(this.HTypeDefinition).def(() -> this.HTypeDefinition = new HTypeDefinitionCtr());
  }
  @:isVar public var HField(get,null):HFieldCtr;
  private function get_HField():HFieldCtr{
    return __.option(this.HField).def(() -> this.HField = new HFieldCtr());
  }
  @:isVar public var HFieldType(get,null):HFieldTypeCtr;
  private function get_HFieldType():HFieldTypeCtr{
    return __.option(this.HFieldType).def(() -> this.HFieldType = new HFieldTypeCtr());
  }
  @:isVar public var HFunctionArg(get,null):HFunctionArgCtr;
  private function get_HFunctionArg():HFunctionArgCtr{
    return __.option(this.HFunctionArg).def(() -> this.HFunctionArg = new HFunctionArgCtr());
  }
  @:isVar public var HComplexType(get,null):HComplexTypeCtr;
  private function get_HComplexType():HComplexTypeCtr{
    return __.option(this.HComplexType).def(() -> this.HComplexType = new HComplexTypeCtr());
  }
  @:isVar public var HConstant(get,null):HConstantCtr;
  private function get_HConstant():HConstantCtr{
    return __.option(this.HConstant).def(() -> this.HConstant = new HConstantCtr());
  }
  @:isVar public var HTypePath(get,null):HTypePathCtr;
  private function get_HTypePath():HTypePathCtr{
    return __.option(this.HTypePath).def(() -> this.HTypePath = new HTypePathCtr());
  }
  @:isVar public var HFunction(get,null):HFunctionCtr;
  private function get_HFunction():HFunctionCtr{
    return __.option(this.HFunction).def(() -> this.HFunction = new HFunctionCtr());
  }
  @:isVar public var HObjectField(get,null):HObjectFieldCtr;
  private function get_HObjectField():HObjectFieldCtr{
    return __.option(this.HObjectField).def(() -> this.HObjectField = new HObjectFieldCtr());
  }
  @:isVar public var HTypeParam(get,null):HTypeParamCtr;
  private function get_HTypeParam():HTypeParamCtr{
    return __.option(this.HTypeParam).def(() -> this.HTypeParam = new HTypeParamCtr());
  }
  @:isVar public var HCase(get,null):HCaseCtr;
  private function get_HCase():HCaseCtr{
    return __.option(this.HCase).def(() -> this.HCase = new HCaseCtr());
  }
  @:isVar public var HCatch(get,null):HCatchCtr;
  private function get_HCatch():HCatchCtr{
    return __.option(this.HCatch).def(() -> this.HCatch = new HCatchCtr());
  }
  @:isVar public var HMetadata(get,null):HMetadataCtr;
  private function get_HMetadata():HMetadataCtr{
    return __.option(this.HMetadata).def(() -> this.HMetadata = new HMetadataCtr());
  }
  @:isVar public var HMetadataEntry(get,null):HMetadataEntryCtr;
  private function get_HMetadataEntry():HMetadataEntryCtr{
    return __.option(this.HMetadataEntry).def(() -> this.HMetadataEntry = new HMetadataEntryCtr());
  }
  @:isVar public var HVar(get,null):HVarCtr;
  private function get_HVar():HVarCtr{
    return __.option(this.HVar).def(() -> this.HVar = new HVarCtr());
  }
  @:isVar public var HPropAccess(get,null):HPropAccessCtr;
  private function get_HPropAccess():HPropAccessCtr{
    return __.option(this.HPropAccess).def(() -> this.HPropAccess = new HPropAccessCtr());
  }
  @:isVar public var HTypeParamDecl(get,null):HTypeParamDeclCtr;
  private function get_HTypeParamDecl():HTypeParamDeclCtr{
    return __.option(this.HTypeParamDecl).def(() -> this.HTypeParamDecl = new HTypeParamDeclCtr());
  }
  @:isVar public var HAccess(get,null):HAccessCtr;
  private function get_HAccess():HAccessCtr{
    return __.option(this.HAccess).def(() -> this.HAccess = new HAccessCtr());
  }
  @:isVar public var HTypeDefKind(get,null):HTypeDefKindCtr;
  private function get_HTypeDefKind():HTypeDefKindCtr{
    return __.option(this.HTypeDefKind).def(() -> this.HTypeDefKind = new HTypeDefKindCtr());
  }
  @:isVar public var HPosition(get,null):HPositionCtr;
  private function get_HPosition():HPositionCtr{
    return __.option(this.HPosition).def(() -> this.HPosition = new HPositionCtr());
  }
  @:isVar public var HExprdef(get,null):HExprdefCtr;
  private function get_HExprdef():HExprdefCtr{
    return __.option(this.HExprdef).def(() -> this.HExprdef = new HExprdefCtr());
  }
  // @:isVar public var HArrayDecl(get,null):HArrayDeclCtr;
  // private function get_HArrayDecl():HArrayDeclCtr{
  //   return __.option(this.HArrayDecl).def(() -> this.HArrayDecl = new HArrayDeclCtr());
  // }
}