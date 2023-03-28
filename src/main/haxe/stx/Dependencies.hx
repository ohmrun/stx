package stx;

using stx.Pico;
using stx.Nano;

using stx.Pkg;
using stx.di.DI;

#if macro
  import haxe.macro.*;
  import haxe.macro.Context;
#end

@:keep @:allow(stx.di) class Dependencies{
  private var deferred : stx.di.DI;

  private function new(){
    this.deferred = stx.di.DI.create(null,null,"DEPENDENCIES"); 
  }
  @:isVar private static var instance(get,null)        : Dependencies;
  static function get_instance(){
    return __.option(instance).def(
      () -> {
        //trace("INITIALIZE");
        instance = new Dependencies();
        instance.initialize();
        return instance;
      }
    );
  }
  private static var initialized                : Bool = false;
  private function initialize(){
    if(!initialized){
      initialized   = true;
      var registry  = new stx.di.Registry();
      //trace(registry.length);
      var queue     = new tink.priority.Queue();
      for (clazz in registry){
        //trace(clazz);
        var configurator  = std.Type.createEmptyInstance(clazz);
            configurator.apply(queue);
      }
      for(app in queue){
        var def = __.definition(app);
        //trace('app: $app');
        app.react(instance.deferred);
      }
      var overrides = std.Type.createEmptyInstance(stx.Overrides);
          overrides.react(@:privateAccess instance.deferred);
    }
  }
  #if macro
  private function register(cl:Class<stx.di.Assembly>){
    //trace('stx.Dependencies.register $cl');
    new stx.di.Registry().push(cl);
  }
  #end
}
