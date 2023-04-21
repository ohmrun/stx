package stx.makro.di;

import stx.makro.di.Util;

import haxe.ds.StringMap;

import stx.makro.di.Injector;
import stx.makro.di.Resolvers;
import stx.makro.di.ResolverDef;

@:allow(stx.makro.di) class DI{

	@:noCompletion function _has(id:String):Bool {
		return factories.exists(id);
	}
	@:noCompletion function _add(id:String, factory:DI->Dynamic, ?force:Bool = false):Void {
		//trace('_add $id ${this.id}');
    //trace(factories);
		if (factories.exists(id) && !force)
			throw 'Duplicate factory declaration for $id';
		factories.set(id, factory);
	}

	public function extend():DI {
		var next = copy(null, new StringMap(), __.uuid());
		// next.copy(this.factories,this.instances);
		// trace('extend: FROM ${this.factories} TO ${next.factories}');
		return next;
	}
	public function concat(that:DI):DI{
		var factories = new StringMap();
		for(key=>val in this.factories){
			factories.set(key,val);
		}
		for(key=>val in that.factories){
			factories.set(key,val);
		}
		return copy(null,factories,__.uuid());		
	}
  public function injector(){
    return new Injector(this);
  }
  public var id(default,null)           : String;
  var instances                         : std.haxe.ds.StringMap<Dynamic>;
  var factories                         : std.haxe.ds.StringMap<DI->Dynamic>;
  var resolver(default,null)            : Resolver = Resolvers.resolves();

  static function copyMap<T>(map:StringMap<T>):StringMap<T>{
    var next = new StringMap();
    for(key in map.keys()){
      //DI.print('copying: $key');
      next.set(key,map.get(key));
    }
    return next;
  }
  function copy(?factories,?instances,?id){
    var _instances       = instances == null ? this.instances : instances;
    var _factories       = factories == null ? this.factories : factories;
    var _id              = id == null ? this.id : id;
    var next             = new DI(copyMap(_factories),copyMap(_instances));
    return next;
  }
  public function new(?factories:StringMap<DI->Dynamic>,?instances:StringMap<Dynamic>,?id) {
    //DI.print('new: ${this.id} $factories, $instances');
    this.id         = __.option(id).def(() -> __.uuid());
    this.instances  = __.option(instances).defv(new StringMap());
    this.factories  = __.option(factories).defv(new StringMap());
  }
  static public function create(?factories:StringMap<DI->Dynamic>,?instances:StringMap<Dynamic>,?id){
    var out   = new DI(factories,instances,id);
    return out;
  }
  public function toString(){
    return '$id';
  }
}
