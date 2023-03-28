package stx.assert.ds.xset.eq.term;

class XSetPlace implements EqApi<XSetPlaceT> extends Clazz{
  public function comply(a:XSetPlaceT,b:XSetPlaceT):Equaled{
    return switch ([a,b]){
      case ([Field(idx,key),Field(idx0, key0)]) : 
        idx == idx0 && key == key0 ? AreEqual : NotEqual;
      case ([Index(idx),Index(idx0)]): 
        idx == idx0 ? AreEqual : NotEqual;
      default : 
        NotEqual; 
    }
  }
}