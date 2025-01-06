package stx.assert.ds.comparable;

import stx.ds.RedBlackSet as TRedBlackSet;

class RedBlackSet<T> extends ComparableCls<TRedBlackSet<T>>{
  final _T : Comparable<T>;
  
  public function new(T:Comparable<T>){
    this._T = T;
  }
  public function eq(){
    return new stx.assert.ds.eq.RedBlackSet(_T.eq());
  }
  public function lt(){
    return new stx.assert.ds.ord.RedBlackSet(_T.lt());
  }
}