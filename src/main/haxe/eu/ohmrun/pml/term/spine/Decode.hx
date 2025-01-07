package eu.ohmrun.pml.term.spine;

import stx.om.spine.Spine in TSpine;

class Decode extends Clazz{
  public function apply(expr:PExpr<Atom>):PmlSpine{
    __.log().trace('$expr');
    return switch(expr){
      case PLabel(name)     : Primate(PSprig(Textal(':$name')));
      case PApply(name,arg) : Collate(
        Record.fromMap(
          ['#$name' => apply(arg)]
        )
      );
      case PGroup(list) :
        Collect(list.toCluster().map(
          x -> apply(x)
        ).map(x -> () -> x));
      case PArray(array) :
          Collect(array.map(
            x -> apply(x)
          ).map(x -> () -> x));
      case PSet(set) :
          Collect(set.map(
            x -> apply(x)
          ).map(x -> () -> x));
      case PValue(value)      : value.toPrimitive();
      case PEmpty             : Unknown;
      case PAssoc(map)        : 
        final is_map = map.lfold(
          (n:Tup2<PExpr<Atom>,PExpr<Atom>>,m:Bool) -> return m ? n.fst().get_string().is_defined() : m,
          true
        );
        return is_map.if_else(
          () -> Collate(map.map(
            __.detuple(
             (x:PExpr<Atom>,y:PExpr<Atom>) -> {
              final l = x.get_string().fudge();
              final r = apply(y);
              return Field.make(l,() -> r);
             }
            )
          )),
          () -> Collect(
            map.map(
              __.detuple(
                (l,r) -> {
                  final r = Predate(tuple2(apply(l),apply(r)));
                  return () -> r;
                }
              )
            )
          )
      );
    }
  }
}
