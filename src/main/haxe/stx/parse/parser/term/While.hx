package stx.parse.parser.term;

/**
 * Call parser on input until it fails and return the successess.
 */
class While<P,R> extends Base<P,Cluster<R>,Parser<P,R>>{
  public function new(delegation:Parser<P,R>,?tag:Option<String>,?pos:Pos){
    super(delegation,tag,pos);
  }
  /**
   * Recursively calls parser until it fails and returns a cluster of the results. 
   * @see https://haxe.org/manual/cr-tail-recursion-elimination.html
   * @param ipt 
   * @return ParseResult<P,Cluster<R>>
   */
  override public final function apply(ipt:ParseInput<P>):ParseResult<P,Cluster<R>>{
    final result = [];
    function rec(ipt:ParseInput<P>){
      final res = delegation.apply(ipt);
      return switch(res.is_ok()){
        case true : 
          for (v in res.value){
            result.push(v);
          }
          rec(res.asset);//Uh-Oh
        case false : 
          switch(result.length == 0){
            case true  : res.asset.no(E_Parse_NoOutput);
            case false : res.asset.ok(Cluster.lift(result));
          }
      }
    }
    return rec(ipt);
  }
}