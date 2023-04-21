package stx.makro.di;

class Package extends Packed<stx.makro.di.Package>{
  public function new(){
    super(__.here());
  }
}
enum WootDeWoot{
  Frublub;
}