package stx.makro.di.core;


interface AssemblyApi{
  public function react(di:stx.makro.di.DI):Void;
  public function apply(q:Array<{ data : AssemblyApi, id : String}>):Void;
}