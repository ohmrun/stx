package stx.makro;

typedef Printer               = haxe.macro.Printer;

typedef HAccessCtr                  = stx.makro.expr.HAccess.HAccessCtr;
typedef HAccessDef                  = stx.makro.expr.HAccess.HAccessDef;
typedef HAccess                     = stx.makro.expr.HAccess;

typedef HExprCtr                    = stx.makro.expr.HExpr.HExprCtr;
typedef HExprDef                    = stx.makro.expr.HExpr.HExprDef;
typedef HExpr                       = stx.makro.expr.HExpr;

typedef HBinopCtr                   = stx.makro.expr.HBinop.HBinopCtr;
typedef HBinopDef                   = stx.makro.expr.HBinop.HBinopDef;
typedef HBinop                      = stx.makro.expr.HBinop;

typedef HCaseCtr                    = stx.makro.expr.HCase.HCaseCtr;
typedef HCaseDef                    = stx.makro.expr.HCase.HCaseDef;
typedef HCase                       = stx.makro.expr.HCase;

typedef HCatchCtr                   = stx.makro.expr.HCatch.HCatchCtr;
typedef HCatchDef                   = stx.makro.expr.HCatch.HCatchDef;
typedef HCatch                      = stx.makro.expr.HCatch;

typedef HComplexTypeCtr             = stx.makro.expr.HComplexType.HComplexTypeCtr;
typedef HComplexTypeDef             = stx.makro.expr.HComplexType.HComplexTypeDef;
typedef HComplexType                = stx.makro.expr.HComplexType;

typedef HConstantCtr                = stx.makro.expr.HConstant.HConstantCtr;
typedef HConstantDef                = stx.makro.expr.HConstant.HConstantDef;
typedef HConstant                   = stx.makro.expr.HConstant;

typedef HExprdefCtr                 = stx.makro.expr.HExprdef.HExprdefCtr;
typedef HExprdefDef                 = stx.makro.expr.HExprdef.HExprdefDef;
typedef HExprdef                    = stx.makro.expr.HExprdef;

#if (hax_ver > 4.205)
typedef HExprDefKind                = stx.makro.expr.HExprDefKind;
#end

typedef HFieldCtr                   = stx.makro.expr.HField.HFieldCtr;
typedef HFieldDef                   = stx.makro.expr.HField.HFieldDef;
typedef HField                      = stx.makro.expr.HField;


typedef HFieldTypeCtr               = stx.makro.expr.HFieldType.HFieldTypeCtr;
typedef HFieldTypeDef               = stx.makro.expr.HFieldType.HFieldTypeDef;
typedef HFieldType                  = stx.makro.expr.HFieldType;

typedef HFunctionCtr                = stx.makro.expr.HFunction.HFunctionCtr;
typedef HFunctionDef                = stx.makro.expr.HFunction.HFunctionDef;
typedef HFunction                   = stx.makro.expr.HFunction;

typedef HFunctionArgCtr             = stx.makro.expr.HFunctionArg.HFunctionArgCtr;
typedef HFunctionArgDef             = stx.makro.expr.HFunctionArg.HFunctionArgDef;
typedef HFunctionArg                = stx.makro.expr.HFunctionArg;

typedef HFunctionKindCtr            = stx.makro.expr.HFunctionKind.HFunctionKindCtr;
typedef HFunctionKindDef            = stx.makro.expr.HFunctionKind.HFunctionKindDef;
typedef HFunctionKind               = stx.makro.expr.HFunctionKind;

typedef HMetadataCtr                = stx.makro.expr.HMetadata.HMetadataCtr;
typedef HMetadataDef                = stx.makro.expr.HMetadata.HMetadataDef;
typedef HMetadata                   = stx.makro.expr.HMetadata;

typedef HMetadataEntryCtr           = stx.makro.expr.HMetadataEntry.HMetadataEntryCtr;
typedef HMetadataEntryDef           = stx.makro.expr.HMetadataEntry.HMetadataEntryDef;
typedef HMetadataEntry              = stx.makro.expr.HMetadataEntry;

typedef HObjectFieldCtr             = stx.makro.expr.HObjectField.HObjectFieldCtr;
typedef HObjectFieldDef             = stx.makro.expr.HObjectField.HObjectFieldDef;
typedef HObjectField                = stx.makro.expr.HObjectField;

typedef HPositionCtr                = stx.makro.expr.HPosition.HPositionCtr;
typedef HPositionDef                = stx.makro.expr.HPosition.HPositionDef;
typedef HPosition                   = stx.makro.expr.HPosition;

typedef HPropAccessCtr              = stx.makro.expr.HPropAccess.HPropAccessCtr;
typedef HPropAccessSum              = stx.makro.expr.HPropAccess.HPropAccessSum;
typedef HPropAccess                 = stx.makro.expr.HPropAccess;

typedef HQuoteStatusCtr             = stx.makro.expr.HQuoteStatus.HQuoteStatusCtr;
typedef HQuoteStatusDef             = stx.makro.expr.HQuoteStatus.HQuoteStatusDef;
typedef HQuoteStatus                = stx.makro.expr.HQuoteStatus;

typedef HStringLiteralKindCtr       = stx.makro.expr.HStringLiteralKind.HStringLiteralKindCtr;
typedef HStringLiteralKindDef       = stx.makro.expr.HStringLiteralKind.HStringLiteralKindDef;
typedef HStringLiteralKind          = stx.makro.expr.HStringLiteralKind;

typedef HTypeDefinitionCtr          = stx.makro.expr.HTypeDefinition.HTypeDefinitionCtr;
typedef HTypeDefinitionDef          = stx.makro.expr.HTypeDefinition.HTypeDefinitionDef;
typedef HTypeDefinition             = stx.makro.expr.HTypeDefinition;

typedef HTypeDefKindCtr             = stx.makro.expr.HTypeDefKind.HTypeDefKindCtr;
typedef HTypeDefKindDef             = stx.makro.expr.HTypeDefKind.HTypeDefKindDef;
typedef HTypeDefKind                = stx.makro.expr.HTypeDefKind;

typedef HTypeParamCtr               = stx.makro.expr.HTypeParam.HTypeParamCtr;
typedef HTypeParamDef               = stx.makro.expr.HTypeParam.HTypeParamDef;
typedef HTypeParam                  = stx.makro.expr.HTypeParam;

typedef HTypeParamDeclCtr           = stx.makro.expr.HTypeParamDecl.HTypeParamDeclCtr;
typedef HTypeParamDeclDef           = stx.makro.expr.HTypeParamDecl.HTypeParamDeclDef;
typedef HTypeParamDecl              = stx.makro.expr.HTypeParamDecl;

typedef HTypePathCtr                = stx.makro.expr.HTypePath.HTypePathCtr;
typedef HTypePathDef                = stx.makro.expr.HTypePath.HTypePathDef;
typedef HTypePath                   = stx.makro.expr.HTypePath;

typedef HUnopCtr                    = stx.makro.expr.HUnop.HUnopCtr;
typedef HUnopDef                    = stx.makro.expr.HUnop.HUnopDef;
typedef HUnop                       = stx.makro.expr.HUnop;

typedef HVarCtr                     = stx.makro.expr.HVar.HVarCtr;
typedef HVarDef                     = stx.makro.expr.HVar.HVarDef;
typedef HVar                        = stx.makro.expr.HVar;


typedef HMethodCallDef              = stx.makro.expr.HMethodCall.HMethodCallDef;
typedef HMethodCall                 = stx.makro.expr.HMethodCall.HMethodCall;

typedef HExprArray                  = stx.makro.expr.HExprArray;

typedef LiftHExpr                   = stx.makro.expr.HExpr.LiftHExpr;
typedef LiftConstantToHExpr         = stx.makro.expr.lift.LiftConstantToHExpr;
typedef LiftMethodRefToHExpr        = stx.makro.expr.lift.LiftMethodRefToHExpr;
typedef LiftMonikerToHExpr          = stx.makro.expr.lift.LiftMonikerToHExpr;


class Cases{
  static public function foldKeys<T>(m:Monoid<T>,c:Case):Continuation<T,HExpr>{
    return function(constructor:HExpr->T):T{
      var values = c.values.fold(
        (next:stx.makro.alias.StdExpr,memo) -> m.plus(constructor(HExpr.fromExpr(next)),memo),
        m.unit()
      );
      var guard  = c.guard == null ? m.unit() : constructor(HExpr.fromExpr(c.guard));

      var expr   = c.expr == null ? m.unit() : constructor(HExpr.fromExpr(c.expr));

      return m.plus(m.plus(values,guard),expr);
    } 
  }
}
class LiftMetadataEntry{
  static public function makro(md:StdMetadataEntry):MetadataEntry{
    return md;
  }
}
class LiftEBlock {
  #if macro
  static public function toEBlock(arr:Array<haxe.macro.Expr>):HExpr{
    return HExpr.fromExpr({
      expr  : StdExprDef.EBlock(arr.prj()),
      pos   : Context.currentPos()
    });
  }
  #end
}  
class LiftHTypeToComplexType{
  #if macro
  static public function toComplexType(self:HType){
    return tink.macro.Types.toComplex(self.prj());
  }
  #end
}
class LiftExprToHExpr{
  static public function toHExpr(self:haxe.macro.Expr):HExpr{
    return HExpr.lift(self);
  }
}
class LiftHTFunArgArrayWithMethodCallToExpr{
  #if macro
  static public function call(self:HTFunArgArray,m:HMethodCall,pos):HExpr{
    return new stx.makro.Module().expr.HExprdef.Call(
      m.to_macro_at(pos),
      HExprArray.unto((self.map(
        (param) -> param.getMoniker().toExpr()
      )))
    ).to_macro_at(pos);
  }
  #end
}
class LiftTypeGetMetadata{
  static public function get_meta(self:HType):Cluster<HMetadataEntry>{
    return __.option(self.getBaseType()).map(x -> x.meta.get()).defv([]);
  }
}