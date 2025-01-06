package stx.assert.ds.comparable;

import stx.ds.RedBlackMap as TRedBlackMap;

class RedBlackMap<K,V> extends ComparableCls<TRedBlackMap<K,V>>{
  final _K : Comparable<K>;
  final _V : Comparable<V>;
  public function new(_K,_V){
    this._K = _K;
    this._V = _V;
  }
  public function eq(){
    return new stx.assert.ds.eq.RedBlackMap(_K.eq(),_V.eq());
  }
  public function lt(){
    return new stx.assert.ds.ord.RedBlackMap(_K.lt(),_V.lt());
  }
}