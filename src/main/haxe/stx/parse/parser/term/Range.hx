package stx.parse.parser.term;

class Range extends Sync<String,String>{
  
  var min : Int;
  var max : Int;

  public function new(min,max,?pos:Pos){
    super(pos);
    this.min = min;
    this.max = max;
  }
  inline public function apply(ipt:ParseInput<String>):ParseResult<String,String>{
    return switch(ipt.head()){
      case Val(s) : 
        var x = StringTools.fastCodeAt(s,0);
        var v = __.option(x);
        var l = v.map( x -> x >= min).defv(false);
        var r = v.map( x -> x <= max).defv(false);
        __.log().debug('range: $min -> $max');
        l && r ? ipt.tail().ok(s) : ipt.no();
      default : 
        ipt.no(E_Parse_NoHead);
    }
  }
  override public function toString(){
    var l = String.fromCharCode(min);
    var r = String.fromCharCode(max);
    return 'Range[$l...$r]';
  }
}