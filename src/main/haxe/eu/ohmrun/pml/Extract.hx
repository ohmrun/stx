package eu.ohmrun.pml;

using stx.Parse;


class Extract{
  static final e_not_a_group = 'Head not a group';

  private static function handle_head<T,Z>(f:PExpr<T>->ParseResult<PExpr<T>,Z>){
    return (input:ParseInput<PExpr<T>>) -> {
      input.head().fold(
        f,
        (e) -> ParseResult.make(input,None,e),
        ()  -> input.no(E_Parse_EmptyInput)
      );
    } 
  }
  static public function unpack<Z>():Parser<PExpr<Atom>,Z>{
    return Parsers.Anon(
      (input:ParseInput<PExpr<Atom>>) -> 
      handle_head(
        x -> switch(x){
          case PGroup(xs)  : 
            var n = xs.rfold(
             (next,memo:ParseInput<PExpr<Atom>>) -> memo.prepend((next))
             ,input.tail().prepend(PValue(Nul))
            );
            n.nil();
          default         : input.no();
        }
      )(input),
      Some('unpack')
    );
  }
  static public function wordish():Parser<PExpr<Atom>,String>{
    return Parsers.Anon(
      (input:ParseInput<PExpr<Atom>>) -> handle_head(
        x -> switch((x)){
          case PValue(Sym(s)) : input.tail().ok(s);
          case PValue(Str(s))   : input.tail().ok(s);
          case PLabel(x)        : input.tail().ok(x);
          default : input.no();
        }
      )(input),
      Some('wordish')
    );
  }
  static public function nul(name){
    return Parsers.Anon(
      (input) -> {
        return handle_head(
          x -> switch((x)){
            case PValue(Nul)  : input.tail().nil();
            default           : input.no();
          }
        )(input);
      },
      Some('nul $name')
    );
  }
  
  static public function symbol(name:String){
    return Parsers.Anon(
      (input:ParseInput<PExpr<Atom>>) -> {
        return handle_head(
          x -> switch((x)){
            case PValue(Sym(s)) if (s == name): input.tail().ok(s);
            case PValue(Sym(s))               : input.no();
            default                           : input.no();
          }
        )(input);
      },
      Some('symbol')
    );
  }
  static public function text(name:String){
    return Parsers.Anon(
      (input:ParseInput<PExpr<Atom>>) -> {
        return handle_head(
          x -> switch((x)){
            case PValue(Sym(s)) if (s == name): input.tail().ok(s);
            case PValue(Str(s))   if (s == name): input.tail().ok(s);
            case PValue(Str(s))                 : input.no();
            case PLabel(s)        if (s == name): input.tail().ok(s);
            case PLabel(s)                      : input.no();
            case PValue(Sym(s))                 : input.no();
            default                             : input.no(E_Parse_NoOutput);
          }
        )(input);
      },
      Some('string')
    );
  }
  static public function matches<T>(p:Parser<String,T>):Parser<PExpr<Atom>,T>{
    return Parsers.Anon(
      (ipt:ParseInput<PExpr<Atom>>) -> {
        switch(ipt.head()){
          case Val(PValue(Sym(s))) | Val(PValue(Str(s))) | Val(PLabel(s)) :
            final result = p.apply(s.reader());
            return if(result.is_ok()){
              result.value.fold( 
                ok -> ipt.tail().ok(ok),
                () -> ipt.tail().nil()
              );
            }else{
              ParseResult.make(ipt,None,result.error);
            }
          default                                 : ipt.no(E_Parse_EmptyInput);
        }
      },
      Some('matches')
    );
  }
  /**
    Unpacks the items in head if its a PGroup, then uses the `nul` created by unpack to determine if a group has been fully parsed.
  **/
  static public function imbibe<T>(p:Parser<PExpr<Atom>,T>,name:String):Parser<PExpr<Atom>,T>{
    return Parsers.AndR(unpack(),p).and_(nul(name));
  }
  static public function fmap<T>(f:PExpr<Atom> -> Option<T>,name:String):Parser<PExpr<Atom>,T>{
    return Parsers.Anon(
      (input:ParseInput<PExpr<Atom>>) -> handle_head(
        (x) -> switch(f(x)){
          case Some(x)  : input.tail().ok(x);
          case None     : input.no();
        }
      )(input),
      name
    );
  }
}