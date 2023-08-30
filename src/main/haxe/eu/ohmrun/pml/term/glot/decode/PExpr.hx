package eu.ohmrun.pml.term.glot.decode;

import eu.ohmrun.pml.PExpr in TPExpr;

final decode = __.pml().glot().decode;

class PExpr extends Clazz{
  public function apply(self:TPExpr<Atom>):Upshot<Dynamic,GlotFailure>{
    return switch(self){
      case PEmpty     : __.accept(null);
      case PValue(x)  : __.accept(x.toString());
      case PLabel(x)  : __.accept(x);
      case PApply(x)  : __.accept(x);
      case PGroup(
        Cons(PGroup(Cons(x,Cons(y,Nil))),xs)) : decode.EnumValue.apply(self);
      case PGroup(xs) : Upshot.bind_fold(
        xs,
        (next:TPExpr<Atom>,memo:Cluster<Dynamic>)-> {
          return apply(next).map(memo.snoc);
        },
        [].imm()
      );
      case PArray(xs) : Upshot.bind_fold(
        xs,
        (next:TPExpr<Atom>,memo:Cluster<Dynamic>)-> {
          return apply(next).map(memo.snoc);
        },
        [].imm()
      );
      case PSet(_)  : __.reject(f -> f.of(E_Glot('Set not expected here')));
      case PAssoc(_) : decode.Object.apply(self);
    }
  }
}