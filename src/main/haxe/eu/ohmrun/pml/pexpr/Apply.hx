package eu.ohmrun.pml.pexpr;

abstract class Apply<P> extends Clazz{
  public function comply(key:String,val:PExpr<P>):Upshot<PExpr<P>,PmlFailure>{
    return __.reject(__.fault().of(E_Pml_NoPApply(key)));
  }
  public function apply(self:PExpr<P>):Upshot<PExpr<P>,PmlFailure>{
    __.log().trace('${self.toString()}');
    return (switch(self){
      case PEmpty         : __.accept(PEmpty);
      case PLabel(name)   : __.accept(PLabel(name));
      case PValue(value)  : __.accept(PValue(value));
      case PApply(x,arg)  : comply(x,arg);
      case PGroup(list)   : Upshot.bind_fold(
        list,
        (n:PExpr<P>,m:LinkedList<PExpr<P>>) -> apply(n).map(x -> m.snoc(x)),
        LinkedList.unit()
      ).map(PGroup);
      case PArray(array): Upshot.bind_fold(
        array,
        (n:PExpr<P>,m:Cluster<PExpr<P>>) -> apply(n).map(x -> m.snoc(x)),
        Cluster.unit()
      ).map(PArray);
      case PSet(arr):
        Upshot.bind_fold(
          arr,
          (n:PExpr<P>,m:Cluster<PExpr<P>>) -> apply(n).map(x -> m.snoc(x)),
          Cluster.unit()
        ).map(PSet);
      case PAssoc(map):
        Upshot.bind_fold(
          map,
          (n:Tup2<PExpr<P>,PExpr<P>>,m:Cluster<Tup2<PExpr<P>,PExpr<P>>>) -> { 
            return apply(n.fst()).flat_map(
              (l) -> apply(n.snd()).map( r -> tuple2(l,r))
            ).map(x -> m.snoc(x));
          },
          Cluster.unit()
        ).map(PAssoc);
    }).flat_map(
      x -> {
        //__.log().trace(x.toString());
        return switch(x){
          default           : __.accept(x);
        }
      }
    );
  }
}