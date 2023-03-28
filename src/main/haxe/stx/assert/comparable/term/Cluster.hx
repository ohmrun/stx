package stx.assert.comparable.term;

class Cluster<T> extends ComparableCls<stx.Cluster<T>>{
  final delegate : Comparable<T>;
  public function new(delegate){
    this.delegate = delegate;
  }
  public function eq() : Eq<stx.Cluster<T>>{
    return Eq.Cluster(delegate.eq());
  }
  public function lt() : Ord<stx.Cluster<T>>{
    return Ord.Cluster(delegate.lt());
  }
}