package stx.nano.scheduler;

import haxe.MainLoop;

class Haxe{
  static public function apply(self:Cycle,?pos:Pos):Void{
    // __.log().trace('Haxe.apply');
    final cycle_ref : Ref<Cycle>        = self; 
    var ready       = true;
    var event : MainEvent       = null;
        event       = MainLoop.add(
          (function start(){
            // __.log().trace('ready: $ready');
            switch(ready){
              case false : 
             case true  : 
                switch(cycle_ref.value?.after){
                  case null :
                    // __.log().trace('${cycle_ref.value}');
                    event.stop();
                  case after    : 
                    ready = false;
                    after.handle(
                      (after) -> {
                        ready = true;
                        cycle_ref.value = after;
                      }
                    );
                };
            }
            
          })
        );
  }
}