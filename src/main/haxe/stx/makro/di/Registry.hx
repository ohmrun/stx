package stx.makro.di;

@:forward(iterator,push,length,map)abstract Registry(Array<Class<stx.makro.di.core.Assembly>>){
  static var instance : Array<Class<stx.makro.di.core.Assembly>>;
  public function new(){
    if(instance == null){
      instance = [];
    }
    this = instance;
  }
}