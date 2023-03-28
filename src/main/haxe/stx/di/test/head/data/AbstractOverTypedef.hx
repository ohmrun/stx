package stx.di.test.head.data;

@:forward abstract AbstractOverTypedef(Typedef) from Typedef to Typedef{
  public function new(){
    this = "";
  }
}