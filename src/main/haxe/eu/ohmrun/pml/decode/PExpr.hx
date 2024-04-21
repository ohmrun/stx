package eu.ohmrun.pml.decode;

using stx.Show;

import eu.ohmrun.pml.PExpr in TPExpr;

class PExpr extends Clazz{
  public function apply(self:TPExpr<Atom>):Upshot<Dynamic,PmlFailure>{
    trace(self.toString());
    return switch(self){
      case PEmpty     : __.accept(null);
      case PValue(x)  : __.accept(x.toString());
      case PLabel(x)  : __.accept(x);
      case PApply(x)  : __.accept(x);
      case PGroup(
        Cons(PGroup(Cons(PLabel(x),Cons(PLabel(y),Nil))),xs)
      ) : 
        trace('${x}.$y is enum with ${xs}');
        for(i in xs){
          trace(i.toString());
        }
        final xsI : Cluster<eu.ohmrun.pml.PExpr<Atom>> = xs.toCluster();
        new eu.ohmrun.pml.decode.EnumValue().apply({ name : y, path : x, args : xsI });
      case PGroup(xs) : 
        Upshot.bind_fold(
          xs,
          (next:TPExpr<Atom>,memo:Cluster<Dynamic>)-> {
            trace("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
            trace('bfore: ${next.toString()}');
            final result = apply(next);
            trace('after: $result');
            trace("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
            return result.map(memo.snoc);
          },
          [].imm()
        );
      case PArray(xs) : 
        Upshot.bind_fold(
          xs,
          (next:TPExpr<Atom>,memo:Cluster<Dynamic>)-> {
            trace("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
            trace('bfore: ${next.toString()}');
            final result = apply(next);
            trace('after: $result');
            trace("'+++++++++++++++++++++++++++++++'");
            return result.map(memo.snoc);
          },
          [].imm()
        );
      case PSet(xs)  : Upshot.bind_fold(
        xs,
        (next:TPExpr<Atom>,memo:Cluster<Dynamic>)-> {
          return apply(next).map(memo.snoc);
        },
        [].imm()
      ).map(x -> PmlSet.lift(x));
      case PAssoc(_) : new Object().apply(self);
    }
  }
}