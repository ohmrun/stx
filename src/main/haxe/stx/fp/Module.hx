package stx.fp;

class Module extends Clazz{
  public function with<A,B,C>(a:A,b:B):With<A,B,C>{
    return (c:C) -> __.triple(a,b,c);
  }  
}