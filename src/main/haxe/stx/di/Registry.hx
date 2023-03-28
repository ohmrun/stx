package stx.di;

@:forward(iterator,push,length,map)abstract Registry(Array<Class<stx.di.Assembly>>){
  static var instance : Array<Class<stx.di.Assembly>>;
  public function new(){
    if(instance == null){
      instance = [];
    }
    this = instance;
  }
}