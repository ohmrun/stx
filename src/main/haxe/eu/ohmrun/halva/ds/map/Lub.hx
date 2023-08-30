package eu.ohmrun.halva.ds.map;

class Lub<K,V> extends stx.fp.SemiGroup.SemiGroupCls<LVar<RedBlackMap<K,V>>>{
  final K       : Comparable<LVar<RedBlackMap<K,V>>>;
  final V       : Comparable<V>;
  public function new(K,V){
    super();
    this.K    = K;
    this.V    = V;
  }
  public function plus(lhs:LVar<RedBlackMap<K,V>>,rhs:LVar<RedBlackMap<K,V>>){
    return lhs.is_defined().if_else(
      () -> lhs.zip(rhs).flat_map(
        __.decouple(
          (a:RedBlackMap<K,V>,b:RedBlackMap<K,V>) -> {
            trace('$a $b');
            final free      = a.unit();
            final both      = a.union(b);
            var fail        = false;
            final do_fail   = () -> fail = true;
  
            for(tp in both.toIterKV().toIter()){
              var k = tp.key;
              var v = tp.val;
  
              final l = a.get(k);
              final r = b.get(k);
              switch([l,r]){
                case [Some(lI),Some(rI)] : 
                  trace('$lI,$rI');
                  if(V.lt().comply(rI,lI).is_less_than()){
                    do_fail();
                  }  
                case [Some(_),None] : 
                  do_fail();          
                default : 
              } 
              trace(fail);
              if(fail){
                break;
              }
            }
            if(fail){
              TOP;
            }else{
              HAS(both,rhs.frozen);
            }
          }
        )
      ),
      () -> rhs
    );
  }
}