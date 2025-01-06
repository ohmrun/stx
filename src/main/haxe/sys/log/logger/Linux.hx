package sys.log.logger;

import stx.log.Stamp;
import stx.log.output.term.Full;
#if (sys || nodejs)
#if (!macro)
  import sys.io.Process;
#end
class Linux extends stx.log.logger.Unit{
  public function new(?logic:stx.log.Logic<Any>,?format:stx.log.core.Format){
    super(logic,__.option(format).defv(new stx.log.core.format.Column()),new LinuxOutput());
  }
}
private class LinuxOutput extends Full{
  override public function render( v : Dynamic, infos : LogPosition, stamp : Stamp ) : Void{
    //.haxe.Log.trace(v);
    var cols = new Process('tput',['cols']);
    var val  = cols.stdout.readAll().toString();
    var args : Array<String> = ["-t","-s","|"];
    var proc = new Process('column',args);
        proc.stdin.writeString(Std.string(v));
        proc.stdin.writeString("\n");
        proc.stdin.close();
    var error = proc.stderr.readAll();

    if(error.length > 0){
      throw error.toString();
    }else{
      super.render(proc.stdout.readAll().toString(),infos,stamp);
    }
  }
}
#end