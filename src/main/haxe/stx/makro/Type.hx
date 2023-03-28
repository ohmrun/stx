package stx.makro;


typedef MakroTypeFailureSum     = stx.fail.MakroTypeFailure.MakroTypeFailureSum;
typedef MakroTypeFailure        = stx.fail.MakroTypeFailure;

typedef HAbstractType           = stx.makro.type.HAbstractType;
typedef HType                   = stx.makro.type.HType;
typedef HTFunArg                = stx.makro.type.HTFunArg;
typedef HTFunArgCluster         = stx.makro.type.HTFunArgCluster;
typedef Identity                = stx.makro.type.Identity;

typedef HBaseType               = stx.makro.type.HBaseType;

typedef HTypeParameter          = stx.makro.type.HTypeParameter;
typedef HModuleType             = stx.makro.type.HModuleType;
typedef HEnumValueConstructor   = stx.makro.type.HEnumValueConstructor;

typedef HEnumType               = stx.makro.type.HEnumType;
typedef HClassType              = stx.makro.type.HClassType;

typedef HClassAndParam          = stx.makro.type.HClassAndParam;
typedef HClassAndParamDef       = stx.makro.type.HClassAndParam.HClassAndParamDef;
typedef HClassKind              = stx.makro.type.HClassKind;

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
