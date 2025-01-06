package eu.ohmrun.pml.decode;

class Object extends Clazz{ 
  public function apply(self:PExpr<Atom>){
    return switch(self){
      case PAssoc(arr) : 
        Upshot.bind_fold(
          arr,
          (next:Tup2<PExpr<Atom>,PExpr<Atom>>,memo:Cluster<Couple<String,Dynamic>>) -> {
            final name = switch(next.fst()){
              case PLabel(s)  : __.accept(s);
              default         : __.reject(f -> f.of(E_Pml('lhs should be PLabel')));
            }
            final data = new eu.ohmrun.pml.decode.PExpr().apply(next.snd());
            return name.zip(data).map(memo.snoc);
          },
          Cluster.unit()
        ).map(
          cls -> cls.lfold(
            (next:Couple<String,Dynamic>,memo:Dynamic) -> {
              Reflect.setField(memo,next.fst(),next.snd());
              return memo;
            },
            {}
          )
        );
      default : __.reject(f -> f.of(E_Pml('Not a PAssoc')));
    }
  }
}