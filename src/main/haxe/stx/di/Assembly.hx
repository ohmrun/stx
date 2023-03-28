package stx.di;

import tink.priority.Item;
import tink.priority.Queue;
import tink.priority.ID;

@:stx.Dependencies.register(__)
class Assembly implements AssemblyApi{
  private final function new(){
    
  }
  public function react(di:stx.di.DI){
    
  }
  public function apply(q:Queue<AssemblyApi>){
    var cls = __.definition(this).identifier().toString();
    var id  = '$cls::apply';
    q.add({
      data : this,
      id   : id
    });
  }
}