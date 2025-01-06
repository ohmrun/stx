
package stx.fail;

enum abstract ParseFailure(String){
  var EOF   = "EOF";
  var ERROR = "ERROR";
  var FATAL = "FATAL";
}