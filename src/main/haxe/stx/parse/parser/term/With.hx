package stx.parse.parser.term;


class With<I,T,U,V> extends ParserCls<I,V>{
  final lhs : Parser<I,T>;
  final rhs : Parser<I,U>;

  public function new(l:Parser<I,T>,r:Parser<I,U>,?pos:Pos){
    #if debug
    __.assert().that().exists(l);
    __.assert().that().exists(r);
    #end
    //__.log().debug(_ -> _.thunk(() -> '${l} ${r}'));
    //__.log().debug(_ -> _.thunk(() -> '${l.tag} ${r.tag}'));
    this.lhs = l;
    this.rhs = r;
    super(None,pos);
  }
  public function transform(lhs:Null<T>,rhs:Null<U>):Option<V>{
    return None;
  }
  function check(){
      __.assert().expect().exists().crunch(lhs);
      __.assert().expect().exists().crunch(rhs);
  }
  override inline public function apply(input:ParseInput<I>):ParseResult<I,V>{  
    // trace("with apply");
    var res =lhs.apply(input);
    #if debug
    __.log().trace(_ -> _.thunk(
      () -> {
        final parser =lhs.toString();
        final result = () -> res.toString();
        return 'lh parser result: ${result()} ${res.is_ok()} $parser ';
      }
    ));
    #end
    return switch(res.is_ok()){
      case true:
        // trace("fst ok"); 
        final resI = rhs.apply(res.asset);
        #if debug
        __.log().trace(_ -> _.thunk(
          () -> {
            final parser = rhs.toString();
            final result = resI.toString();
            return 'rh parser: $parser result: $result $this';
          }
        ));
        #end
        switch(resI.is_ok()){
          case true : 
            final result = transform(res.value.defv(null),resI.value.defv(null));
            #if debug
            __.log().trace(_ -> _.thunk(() -> {
              var parsers = 'With(${lhs}  ${rhs})';
              return 'parsers: $parsers, result: $result';
            }));
            #end
            switch(result){
              case Some(x)  : resI.asset.ok(x);
              case None     : resI.asset.nil();
            }
          case false : 
            switch(resI.is_fatal()){
              case true   : resI.fails(); 
              case false  : 
                input.defect(resI.error);
            }
        }
      case false : 
        // trace("fst not ok"); 
        input.defect(res.error);
    }  
  }
  override public function toString():String{
    return 'With($lhs $rhs)';
  }
}
