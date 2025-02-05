package stx.parse.parser.term;

class CharCode extends Sync<String,String>{
  final code : Int;
  public function new(code,?id){
    super(Some('code'),id);
    this.code = code;
  }
  override public function apply(ipt:ParseInput<String>):ParseResult<String,String>{
    return ipt.head().fold(
      ok -> ok.charCodeAt(0) == code ? ipt.tail().value(ok) : ipt.error(),
      e   -> ipt.error().defect(e),
      ()  -> ipt.error()
    );
  }
  override public function toString(){
    final v = String.fromCharCode(code);
    return "'" + v + "'";
  }
}
