package stx.parse.parser.term;

class Ors<I,T> extends Base<I,T,Array<Parser<I,T>>>{
  public function new(delegation,?id:Pos){
    super(delegation,id);
  }
  override function check(){
    for(delegate in delegation){
      __.assert().that().exists(delegate);
    }
  }
  override public function apply(input:ParseInput<I>):ParseResult<I,T>{
    var idx    = 1;
    final res  = delegation[0].apply(input);
    var errs  : Error<ParseFailure> = null;
    function set_error(e){
      if (errs == null){
        errs = e;
      }else{
        errs = e.concat(errs);
      }
    }
    function rec(res:ParseResult<I,T>):ParseResult<I,T>{
      return switch(res.is_ok()){
        case true  : res;
        case false :
          switch(res.is_fatal()){
            case true  : res;
            case false :
              set_error(res.error);
              if(idx < delegation.length){
                var n = idx;
                idx   = idx + 1;
                var d = delegation[n];

                #if debug __.log().trace(_ -> _.thunk(() -> '${res.asset.index} $d')); #end
                
                final resI = d.apply(res.asset);

                if(!resI.is_ok()){
                  ParseResult.make(resI.asset,None,resI.error);
                }else{
                  resI.defect(errs);
                }
              }else{
                var opts = delegation.map(_ -> _.tag);
                ParseResult.make(res.asset,None,res.error);
                //res.with_errata(res.asset.erration('Ors $opts',false));
              }
            }
      }
    }
    return rec(res);
  }
}