package stx.assert.ds.xset.comparable.term;

class XSetPlace extends ComparableCls<XSetPlaceT> {
  public function new(){}
  public function eq(){
    return new XSetPlaceEq();
  }
  public function lt(){
    return new XSetPlaceOrd();
  }
}