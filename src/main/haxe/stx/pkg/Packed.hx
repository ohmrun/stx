package stx.pkg;

class Packed<T>{
  var pkg : Pkg;
  public function new(pos:Position){
    this.pkg = __.pkg(pos);
  }
}