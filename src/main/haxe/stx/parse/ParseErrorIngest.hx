package stx.parse;

abstract ParseErrorIngest(Ingest<ParseFailure>) to Ingest<ParseFailure>{
  @:noUsing static public function make(label,loc){
    return new ParseErrorIngest(label,loc);
  }
  public function new(label:String,loc){
    this = Ingest.make(ParseFailure.ERROR,label,loc);
  }
}

