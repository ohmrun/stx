package stx.makro.di;

import stx.fn.Thunk;

class Resolvers{
  @:access(stx.makro.di) static public function resolves():String->(DI->Dynamic){
    return function(type:String):DI->Dynamic {
        return function(target:DI){
            //trace('resolve: ${target.id} $type ${target.factories}');
            var inst = target.instances.get(type);
            // trace(target.factories);
            //trace(type);
            if (inst == null) {
                var factory = target.factories.get(type);
                if (factory == null){
                    throw '"$type" not found: (${target.factories})';
                }else{
                    // var result : Dynamic = Thunk._.cache(() -> factory(target))();
                    // if(result == null){
                    //   throw "no result";
                    // }
                    target.instances.set(type,factory(target));
                    inst = target.instances.get(type);
                }
            }
            return inst;
        }
    }
  }
}