package stx.makro;

typedef MakroTypeFailureSum         = stx.fail.MakroTypeFailure.MakroTypeFailureSum;
typedef MakroTypeFailure            = stx.fail.MakroTypeFailure;

typedef HAbstractType               = stx.makro.type.HAbstractType;
typedef HAbstractTypeCtr            = stx.makro.type.HAbstractType.HAbstractTypeCtr;

typedef HDefType                    = stx.makro.type.HDefType;
typedef HDefTypeCtr                 = stx.makro.type.HDefType.HDefTypeCtr;

typedef HType                       = stx.makro.type.HType;
typedef HTypeCtr                    = stx.makro.type.HTypeCtr;

typedef HTFunArg                    = stx.makro.type.HTFunArg;
typedef HTFunArgCtr                 = stx.makro.type.HTFunArg.HTFunArgCtr;

typedef HTFunArgArray               = stx.makro.type.HTFunArgArray;
typedef HTFunArgArrayCtr            = stx.makro.type.HTFunArgArray.HTFunArgArrayCtr;

typedef HRefCtr                     = stx.makro.type.HRef.HRefCtr;
typedef HRef<T>                     = stx.makro.type.HRef<T>;
typedef HRefDef<T>                  = stx.makro.type.HRef.HRefDef<T>;

typedef HBaseType                   = stx.makro.type.HBaseType;
typedef HBaseTypeCtr                = stx.makro.type.HBaseType.HBaseTypeCtr;

typedef HEnumType                   = stx.makro.type.HEnumType;
typedef HEnumTypeCtr                = stx.makro.type.HEnumType.HEnumTypeCtr;

typedef HEnumField                  = stx.makro.type.HEnumField;
typedef HEnumFieldCtr               = stx.makro.type.HEnumField.HEnumFieldCtr;

typedef HClassTypeCtr               = stx.makro.type.HClassType.HClassTypeCtr;
typedef HClassType                  = stx.makro.type.HClassType;

typedef HClassFieldCtr              = stx.makro.type.HClassField.HClassFieldCtr;
typedef HClassField                 = stx.makro.type.HClassField;

typedef HClassKindCtr               = stx.makro.type.HClassKind.HClassKindCtr;
typedef HClassKind                  = stx.makro.type.HClassKind;

typedef HTypeParameterCtr           = stx.makro.type.HTypeParameter.HTypeParameterCtr;
typedef HTypeParameter              = stx.makro.type.HTypeParameter;

typedef HVarAccess                  = stx.makro.type.HVarAccess;
typedef HVarAccessCtr               = stx.makro.type.HVarAccess.HVarAccessCtr;

typedef HMetaAccessCtr              = stx.makro.type.HMetaAccess.HMetaAccessCtr;
typedef HMetaAccess                 = stx.makro.type.HMetaAccess;


//---------------------------------------------------------------------------------------
typedef HClassAndParam              = stx.makro.type.HClassAndParam;
typedef HClassAndParamDef           = stx.makro.type.HClassAndParam.HClassAndParamDef;

typedef Identity                    = stx.makro.type.Identity;
typedef HSimpleTypeIdentifier       = stx.makro.type.HSimpleTypeIdentifier;
typedef HModuleType                 = stx.makro.type.HModuleType;
typedef HEnumValueConstructor       = stx.makro.type.HEnumValueConstructor;


typedef TypeAppliedValueDef<T>      = stx.makro.type.TypeAppliedValue.TypeAppliedValueDef<T>;
typedef TypeAppliedValue<T>         = stx.makro.type.TypeAppliedValue<T>;

typedef HAbstractTypeCastCtr        = stx.makro.type.HAbstractTypeCast.HAbstractTypeCastCtr;
typedef HAbstractTypeCast           = stx.makro.type.HAbstractTypeCast;

typedef HAbstractTypeBinopCtr       = stx.makro.type.HAbstractTypeBinop.HAbstractTypeBinopCtr;
typedef HAbstractTypeBinop          = stx.makro.type.HAbstractTypeBinop;

typedef HAbstractTypeUnopCtr        = stx.makro.type.HAbstractTypeUnop.HAbstractTypeUnopCtr;
typedef HAbstractTypeUnop           = stx.makro.type.HAbstractTypeUnop;

typedef HClassFieldClusterDef       = stx.makro.type.HClassFieldCluster.HClassFieldClusterDef;
typedef HClassFieldCluster          = stx.makro.type.HClassFieldCluster;

class LiftClassType{
  static public function makro(ct:haxe.macro.Type.ClassType):HClassType{
    return ct;
  }
}
class LiftEnumType{
  static public function makro(e:StdEnumType):HEnumType{
    return new HEnumType(e);
  }
}
class LiftTypeToHType{
  static public inline function toHType(self:haxe.macro.Type){
    return HType.lift(self);
  }
}
class LiftWildcard{
  static public inline function type(self:stx.makro.Module){
    return new stx.makro.type.Module();
  }
}