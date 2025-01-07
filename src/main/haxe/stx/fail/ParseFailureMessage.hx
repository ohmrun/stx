package stx.fail;

enum abstract ParseFailureMessage(String){
  var E_Parse_UndefinedParseDelegate  = "E_Parse_UndefinedParseDelegate";
  var E_Parse_NotEof                  = "E_Parse_NotEof";
  var E_Parse_Failed                  = "E_Parse_Failed";
  var E_Parse_NoParserInArray         = "E_Parse_NoParserInArray";
  var E_Parse_EmptyInput              = "E_Parse_EmptyInput";
  var E_Parse_FilterFailed            = "E_Parse_FilterFailed";
  var E_Parse_OutOfBounds             = "E_Parse_OutOfBounds";
  var E_NoRecursionHead               = "E_NoRecursionHead";
  var E_Parse_PredicateFailed         = "E_Parse_PredicateFailed";
  var E_Parse_NoHead                  = "E_Parse_NoHead";
  var E_Parse_NoOutput                = "E_Parse_NoOutput";
  var E_Parse_NoInput                 = "E_Parse_NoInput";
  var E_Parse_CanNotCommit            = "E_Parse_CanNotCommit";
  var E_Parse_ExtraArgument           = "E_Parse_ExtraArgument";
}