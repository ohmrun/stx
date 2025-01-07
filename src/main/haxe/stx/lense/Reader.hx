package stx.lense;

final _   : LExprCtr                  = __.lense().LExpr;

class Reader{
  static function error(name,detail:Dynamic,?pos:Position):CTR<Fault,Error<LenseFailure>>{
    return (f) -> f.of(E_Lense('$name $detail'));
  }
  static function k_of(e:PExpr<Atom>){
    return switch(e){
      case PGroup(Cons(l,Cons(PValue(N(NInt(n))),Nil))) : 
        switch(l){
          case PValue(Str(s)) | PLabel(s) : __.accept(Coord.make(s,n));
          default                         : __.reject(error('coord',e));
        }
      case PValue(Str(s)) | PLabel(s): 
        __.accept(Coord.make(s));
      default : __.reject(error('coord',e));
    }
  }
  static function ks_of(e:PExpr<Atom>):Upshot<Cluster<Coord>,LenseFailure>{
    return switch(e){
      case PArray(arr)  :
        Upshot.bind_fold(
          arr,
          (next,memo:Cluster<Coord>) -> {
            return k_of(next).map(
              memo.snoc
            );
          },
          Cluster.unit()
        );
      default : __.reject(error('coord',e));
    }
  }
  static public function apply(self:PExpr<Atom>,?rest:String->PExpr<Atom>->Upshot<LExpr<Coord,PExpr<Atom>>,LenseFailure>):Upshot<LExpr<Coord,PExpr<Atom>>,LenseFailure>{
    return switch(self){
      case PApply(x,xs) :
        final args = xs.fold_layer((n,m:Cluster<PExpr<Atom>>) -> m.snoc(n),[]);
        switch(x){
          case 'id'     : __.accept(_.Id());
          case 'const'  : 
            switch(args){
              case Accept([v,d]) :
                __.accept(_.Constant(v,d));
              default                   : 
                __.reject(f -> f.of(E_Lense('const $xs')));
            }
          case 'seq'    : switch(args){
            case Accept([v,d]) : 
              apply(v,rest).flat_map(vI -> apply(d,rest).map((vII) -> _.Sequence(vI,vII)));
            default : 
              __.reject(error('apply',xs));
          }
          case 'hoist' : switch(args){
            case Accept([x]) : 
              k_of(x).map(_.Hoist);
            default : 
            __.reject(error('hoist',xs));
          }
          case 'plunge' : switch(args){
            case Accept([x]) : 
              k_of(x).map(_.Plunge);
            default : 
            __.reject(error('plunge',xs));
          }
          case 'xfork' : switch(args){
            case Accept([PArray(pc),PArray(pa),l,r]) : 
              ks_of(PArray(pc)).zip(ks_of(PArray(pa))).flat_map(
                __.decouple(
                  (pc,pa) -> {
                    return apply(l,rest).zip(apply(r,rest)).map(
                      __.decouple(
                        (lhs,rhs) -> {
                          return _.XFork(pc,pa,lhs,rhs);
                        }
                      )
                    );
                  }
                )
              );
            default : __.reject(error('xfork',xs));
          }
          case 'map' : switch(args){
            case Accept([x]) : apply(x,rest).map(
              x -> _.Map(x)
            );
            default : __.reject(error('map',xs));
          }
          case 'copy' : switch(args){
            case Accept([x,y]) : k_of(x).zip(k_of(y)).map(
              __.decouple(
                (x,y) -> _.Copy(x,y)
              )
            );
            default : __.reject(error('copy',xs));
          }
          case 'merge' : switch(args){
            case Accept([x,y]) : k_of(x).zip(k_of(y)).map(
              __.decouple(
                (x,y) -> _.Merge(x,y)
              )
            );
            default : __.reject(error('merge',xs));
          }
          case 'ccond' : switch(args){
            case Accept([c,_t,_f]) : 
              apply(_t,rest).zip(apply(_f,rest)).map(
                __.decouple(
                  (_t,_f) -> _.CCond(c,_t,_f)
                )
              );
            default : __.reject(error('ccond',xs));
          }
          case 'acond' : switch(args){
            case Accept([cc,ac,_t,_f]) : 
              apply(_t,rest).zip(apply(_f,rest)).map(
                __.decouple(
                  (_t,_f) -> _.ACond(cc,ac,_t,_f)
                )
              );
            default : __.reject(error('acond',xs));
          }
          case 'filter' : switch(args){
            case Accept([ks,d]) : 
              ks_of(ks).map(x -> _.Filter(x,d));
            case Accept([ks])         : 
              ks_of(ks).map(x -> _.Filter(x));
            default : __.reject(error('filter',xs));
          }
          case 'focus' : switch(args){
            case Accept([k,d]) : 
              k_of(k).map(x -> _.Focus(x,d));
            case Accept([k])         : 
              k_of(k).map(x -> _.Focus(x));
            default : __.reject(error('focus',xs));
          }
          case 'rename' : switch(args){
            case Accept([x,y]) : k_of(x).zip(k_of(y)).map(
              __.decouple(
                (x,y) -> _.Rename(x,y)
              )
            );
            default : __.reject(error('rename',xs));
          }
          case x : __.option(rest).fold(
            ok -> rest(x,self),
            () -> __.reject(error(x,null))
          );
        }        
      case PGroup(xs) : 
          Upshot.bind_fold(
            xs,
            (next,memo) -> {
              return apply(next,rest).map(
                x -> _.Sequence(memo,x)
              );
            },
            _.Id()
          );
      default : __.reject(f -> f.of(E_Lense('reader')));
    }
  }
}