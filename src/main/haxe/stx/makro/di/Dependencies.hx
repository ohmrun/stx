package stx.makro.di;

using stx.Pico;
using stx.Nano;

using stx.Pkg;
using stx.makro.di.DI;

#if macro
  import haxe.macro.*;
  import haxe.macro.Context;
#end

@:keep @:allow(stx.makro.di) class Dependencies{
  private var deferred : stx.makro.di.DI;

  private function new(){
    this.deferred = stx.makro.di.DI.create(null,null,"DEPENDENCIES"); 
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
      var registry  = new stx.makro.di.Registry();
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
      var overrides = std.Type.createEmptyInstance(stx.makro.di.Overrides);
          overrides.react(@:privateAccess instance.deferred);
    }
  }
  #if macro
  private function register(cl:Class<stx.makro.di.core.Assembly>){
    //trace('stx.Dependencies.register $cl');
    new stx.makro.di.Registry().push(cl);
  }
  #end
}
