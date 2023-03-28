package stx.ds.xset;

class With<K,V>{
  public var K(default,null) : Comparable<K>;
  public var V(default,null) : Comparable<V>;
  public function new(K,V){
    this.K = K;
    this.V = V;
  }
}