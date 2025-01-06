package stx.makro.di.core;

@:autoBuild(stx.makro.di.core.macro.AssemblyBuild.build())
@:stx.makro.di.Dependencies.register(__)
class Assembly implements AssemblyApi{
  private final function new(){
    
  }
  public function react(di:stx.makro.di.DI){
    
  }
  public function apply(q:Array<{ data : AssemblyApi, id : String}>){
    var cls = __.definition(this).identifier().toString();
    var id  = '$cls::apply';
    q.push({
      data : this,
      id   : id
    });
  }
}