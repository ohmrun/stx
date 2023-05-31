package stx.fail;

enum MakroFailure{
  E_Makro_UnexpectedMacroCondition;//TODO make comprehensible
  E_Makro_CalledFromRuntime;
  E_Makro_ExprIsNotFunction;
  E_Makro_EnumConstructorNotFound(v:EnumValue,cons:String);
}