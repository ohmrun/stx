package stx.assert.comparable.term;

class Anon<T> extends ComparableCls<T>{
  final _eq     : Eq<T>;
  final _lt     : Ord<T>;
  public function new(_eq,_lt){
    this._eq  = _eq;
    this._lt = _lt;
  }
  public function eq(){
    return _eq;
  }
  public function lt(){
    return _lt;
  }
}