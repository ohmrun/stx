package ;

import haxe.io.Path;
import haxe.ds.Option;
using bake.Util;

#if macro
import haxe.macro.Compiler;
#end

class Amble{
  private static function search<T>(self:Array<T>,fn:T->Bool):Option<T>{
    return stx.lift.ArrayLift.search(self,fn);
  }
  #if macro
  static function use(){
    trace('frontend use');
    final bake = Bake.pop();
    trace(bake.toString());
    final root = search(bake.defines,
      x -> x.key == "Amble.root"
    ).map(x -> x.value).fold(x->x,()->".");
     
    if(root!="."){
      final cp = Path.join([bake.root.toString(),root]);
      trace('add classpath: $cp');
      Compiler.addClassPath(cp.toString());
      Compiler.include("",true,[],[cp]);
    }
		tink.SyntaxHub.frontends.whenever(new AmbleFrontend());
  }
  #end
  
  static public function main(){
    boot();
  }
  static public macro function boot(){
    trace('boot');
    final bake = Bake.pop();
    final file = search(bake.defines,
      x -> x.key == "Amble.main"
    ).map(
      x -> x.value.split(".")
    ).fudge(
      'no file defined via `-D` in the haxe invocation'
    );

    trace(file);
    //final ref = 
    return macro $p{file}.main();
  }
}