package stx.assert.comparable.term;

class Lazy<T> extends ComparableCls<T>{
  public var _eq     : Eq<T>;
  public var _lt     : Ord<T>;
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