package stx.di;

class Package extends Packed<stx.di.Package>{
  public function new(){
    super(__.here());
  }
}
enum WootDeWoot{
  Frublub;
}