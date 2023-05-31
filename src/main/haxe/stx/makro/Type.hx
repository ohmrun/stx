package stx.makro;

typedef MakroTypeFailureSum         = stx.fail.MakroTypeFailure.MakroTypeFailureSum;
typedef MakroTypeFailure            = stx.fail.MakroTypeFailure;

typedef HAbstractType               = stx.makro.type.HAbstractType;
typedef HDefType                    = stx.makro.type.HDefType;
typedef HType                       = stx.makro.type.HType;
typedef HTFunArg                    = stx.makro.type.HTFunArg;
typedef HTFunArgArray               = stx.makro.type.HTFunArgArray;
typedef Identity                    = stx.makro.type.Identity;

typedef HBaseType                   = stx.makro.type.HBaseType;

typedef HSimpleTypeIdentifier       = stx.makro.type.HSimpleTypeIdentifier;
typedef HModuleType                 = stx.makro.type.HModuleType;
typedef HEnumValueConstructor       = stx.makro.type.HEnumValueConstructor;

typedef HEnumType                   = stx.makro.type.HEnumType;
typedef HClassType                  = stx.makro.type.HClassType;

typedef HClassAndParam              = stx.makro.type.HClassAndParam;
typedef HClassAndParamDef           = stx.makro.type.HClassAndParam.HClassAndParamDef;
typedef HClassKind                  = stx.makro.type.HClassKind;

typedef HTypeParameter              = stx.makro.type.HTypeParameter;


typedef TypeAppliedValueDef<T>      = stx.makro.type.TypeAppliedValue.TypeAppliedValueDef<T>;
typedef TypeAppliedValue<T>         = stx.makro.type.TypeAppliedValue<T>;

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