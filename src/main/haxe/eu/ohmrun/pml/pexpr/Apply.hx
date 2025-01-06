package eu.ohmrun.pml.pexpr;

abstract class Apply<P> extends Clazz{
  abstract public function comply(key:String,val:PExpr<P>):Upshot<PExpr<P>,PmlFailure>;
  public function apply<T>(self:PExpr<P>):Upshot<PExpr<P>,PmlFailure>{
    __.log().trace('${self.toString()}');
    return (switch(self){
      case PEmpty         : __.accept(PEmpty);
      case PLabel(name)   : __.accept(PLabel(name));
      case PValue(value)  : __.accept(PValue(value));
      case PApply(x)      : __.reject(f -> f.of(E_Pml('No argument for application $x')));
    
      case PGroup(list)   :
        var result  = __.accept(LinkedList.unit());
        var nlist   = list;

        while(nlist.is_defined()){
          var val   = __.accept(nlist.head());
          nlist     = nlist.tail();
          switch(val){
            case Accept(PApply(x)) : 
              if(nlist == Nil){
                result = __.reject(f -> f.of(E_Pml('No argument for application $x')));
                break;
              }else{
                __.log().trace('in group, apply: ${nlist.head().toString()}');
                val   = apply(nlist.head()).flat_map(
                  args -> {
                    __.log().trace('${x}: args: ${args.toString()}');
                    return comply(x,args).map(
                      result -> {
                        __.log().trace('${x}: result: ${result.toString()}');
                        return result;
                      }
                    );
                  }
                );
                nlist = nlist.tail();
              }
            case Accept(x) : 
              //__.log().trace(val);
              val = val.flat_map(x -> apply(x));
            default : 
          }
          result = result.flat_map(
            xs -> {
              return val.map(x -> {
                return xs.snoc(x);
              } );
            }
          );
        }
        result.map(PGroup);

      case PArray(array):
        __.log().trace(':apply/array ${array.map(x -> x.toString())}');
        var result  = __.accept(Cluster.unit());
        var nlist   = array;

        while(nlist.is_defined()){
          var val   = __.accept(nlist.head().defv(null));
          nlist     = nlist.tail();
          switch(val){
            case Accept(PApply(x)) : 
              if(nlist.length == 0){
                result = __.reject(f -> f.of(E_Pml('No argument for application $x')));
                break;
              }else{
                val   = nlist.head().resolve(f -> f.of(E_Pml(x))).flat_map(apply).flat_map(args -> comply(x,args));
                nlist = nlist.tail();
              }
            case Accept(x) : val = val.flat_map(x -> apply(x));
            default : 
          }
          result = result.flat_map(xs -> val.map(x -> xs.snoc(x)));
        }
        result.map(
          x -> {
            __.log().trace('${array.map(x -> x.toString())}');
            return PArray(x);
          }
        );
      case PSet(arr):
        var result  = __.accept(Cluster.unit());
        var nlist   = arr;

        while(nlist.is_defined()){
          var val   = __.accept(nlist.head().defv(null));
          nlist     = nlist.tail();
          switch(val){
            case Accept(PApply(x)) : 
              if(nlist.length == 0){
                result = __.reject(f -> f.of(E_Pml('No argument for application $x')));
                break;
              }else{
                val   = nlist.head().resolve(f -> f.of(E_Pml(x))).flat_map(apply).flat_map(args -> comply(x,args));
                nlist = nlist.tail();
              }
            case Accept(x) : val = val.flat_map(x -> apply(x));
            default : 
          }
          result = result.flat_map(xs -> val.map(x -> xs.snoc(x)));
        }
        result.map(PArray);

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