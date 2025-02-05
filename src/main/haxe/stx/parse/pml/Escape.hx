package stx.parse.pml;

import stx.parse.parsers.StringParsers;
using stx.parse.pml.Escape;

function reg(str:String){
  return StringParsers.reg(str);
}
class Escape{
  static final escaped_double_quote = "\\\"".reg();
}