package stx.parse;
class ParseFatalIngest extends IngestCls<ParseFailure>{
  static public function make(label:String,loc){
    return new ParseFatalIngest(label,loc);
  }
  public function new(label:String,loc){
    super(ParseFailure.FATAL,label,loc);
  } 
}