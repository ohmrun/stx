package stx.parse.pml;

using stx.parse.pml.Parser;

function id(wildcard:Wildcard,s:String){
  return __.parse().parsers().string().id(s);
}

class Parser{
  public function new(){}
  public function lparen_p(){
    return Parsers.Equals(PTLParen).tagged('lparen');
  }
  public function rparen_p(){
    return Parsers.Equals(PTRParen).tagged('rparen');
  }
  public function hash_lbracket_p(){
    return Parsers.Equals(PTHashLBracket).tagged('hash_lbracket');
  }
  public function lbracket_p(){
    return Parsers.Equals(PTLBracket).tagged('lbracket');
  }
  public function rbracket_p(){
    return Parsers.Equals(PTRBracket).tagged('rbracket');
  }
  public function l_square_bracket_p(){
    return Parsers.Equals(PTLSquareBracket).tagged('lbracket');
  }
  public function r_square_bracket_p(){
    return Parsers.Equals(PTRSquareBracket).tagged('rbracket');
  }
  // public function app(input:ParseInput<Token>){
  //   final head = input.head();
  //   final next = input.tail().head();
  //   final data = next.map(
  //     (x) -> switch(x){
  //       case PTLParen | PTHashLBracket | PTLSquareBracket | PTData(_) :
  //         expr_p().apply(input.tail());
  //       default : input.no();
  //     }
  //   );
  //   $type(data);
  // }
  public function val(){
    return Parsers.AndThen(
      Parsers.Something(),
        (t:Token) -> switch(t){
          case PTData(Sym(s)) if (s.startsWith("#"))    : 
              expr_p().then(
                (x) -> PApply(s,x)
              );
          case PTData(Sym(s)) if (s.startsWith(":"))    : Parsers.Succeed(PLabel(s.substr(1)));
          case PTData(atm)                              : Parsers.Succeed(PValue(atm));
          case null                                     : Parsers.Failed();
          default                                       : Parsers.Failed();          
      }
    ).tagged('val');
  }
  function engroup(arr:Cluster<PExpr<Atom>>){
    return PGroup(arr.toLinkedList());
  }
  public function main():stx.parse.Parser<Token,PExpr<Atom>>{
    return expr_p().one_many().then(engroup);
  }
  public function expr_p():stx.parse.Parser<Token,PExpr<Atom>>{
    return [
      set_p(),
      map_p(),
      array_p(),
      val(),
      list_p()
    ].ors();
  }
  public function map_p(){
    return lbracket_p()._and(map_item_p().many()).and_(rbracket_p()).then(PAssoc).tagged("map_p");
  }
  public function map_item_p(){
    return expr_p.cache().and(expr_p.cache()).then(__.decouple(tuple2)).tagged("map_item_p");
  }
  public function list_p():stx.parse.Parser<Token,PExpr<Atom>>{
    return parenthesized(expr_p.cache().tagged('expr').many().tagged('exprs'));
  }
  public function set_p(){
    return hash_lbracket_p()._and(expr_p.cache().many()).and_(rbracket_p()).then(
      (arr) -> PSet(arr)
    ).tagged("set_p");
  }
  private function parenthesized(p:stx.parse.Parser<Token,Cluster<PExpr<Atom>>>):stx.parse.Parser<Token,PExpr<Atom>>{
    return lparen_p()._and(p).and_(rparen_p()).then(
      (arr:Cluster<PExpr<Atom>>) -> {
        return PGroup(arr.toLinkedList());
      }
    );
  }
  private function array_p():stx.parse.Parser<Token,PExpr<Atom>>{
    return l_square_bracket_p()._and(expr_p.cache().many()).and_(r_square_bracket_p()).then(
      (arr:Cluster<PExpr<Atom>>) -> {
        return PArray(arr);
      }
    );
  }
}
