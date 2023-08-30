package eu.ohmrun.pml.term.glot.decode;

final decode = __.pml().glot().decode;

class Object extends Clazz{ 
  public function apply(self:PExpr<Atom>){
    return switch(self){
      case PAssoc(arr) : 
        Upshot.bind_fold(
          arr,
          (next:Tup2<PExpr<Atom>,PExpr<Atom>>,memo:Cluster<Couple<String,Dynamic>>) -> {
            final name = switch(next.fst()){
              case PLabel(s)  : __.accept(s);
              default         : __.reject(f -> f.of(E_Glot('lhs should be PLabel')));
            }
            final data = decode.PExpr.apply(next.snd());
            return name.zip(data).map(memo.snoc);
          },
          [].imm()
        ).map(
          cls -> cls.lfold(
            (next:Couple<String,Dynamic>,memo:Dynamic) -> {
              Reflect.setField(memo,next.fst(),next.snd());
              return memo;
            },
            {}
          )
        );
      default : __.reject(f -> f.of(E_Glot('Not a PAssoc')));
    }
  }
}