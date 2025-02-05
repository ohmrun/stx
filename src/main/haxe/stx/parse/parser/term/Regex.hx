package stx.parse.parser.term;

/**
  The ParseInput pulls from the offset to the end of the string, so I suggest leading the regex with "^".
**/
class Regex extends Sync<String,String>{
  var stamp : String;
  public function new(stamp,?id:Pos){
    super(id);
    this.stamp = stamp;
    this.tag   = Some('Regex($stamp)');
  }
  override public inline function apply(ipt:ParseInput<String>):ParseResult<String,String>{
    var reg         = new EReg(stamp,"g");
    //var ereg        = new RegExp(stamp,"g");
    var is_matched  = ipt.matchedBy(reg.match);
    #if debug
    __.log().debug('stamp="$stamp" matching: ${ipt.take(100)} is_matched="$is_matched" ');
    #end
    return if (is_matched) {
      var match         = reg.matched(0);
      //new RegExp(stamp,"g").parsify(ipt);//TODO
      var length        = match.length;
      final next = ipt.drop(length);
      final data = ipt.take(length);
      #if debug
      @:privateAccess __.log().debug('length ${match.length} data $data index: ${next.content.index}');
      #end
      next.ok(data);
    }else{
      #if debug
      __.log().debug('$stamp not matched to |||${ipt.take()}|||');
      #end
      ipt.no();
    }
  }
  override public function toString(){
    return '~/$stamp/';
  }
}