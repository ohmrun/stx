package stx.log.output.term;

/**
 * Macro context getting confused
 */
class ConsoleOutput implements OutputApi{
  public function new(){
  
  }
  public function render( v : Dynamic, infos : LogPosition, stamp : Stamp ) : Void{
    #if !macro
    @:privateAccess std.Console.log(v);
    #else
    trace(v,infos);
    #end
  }
}