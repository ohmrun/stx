package stx.io;

using stx.Coroutine;
using stx.coroutine.Core;

typedef InputDef  = CoroutineSum<InputRequest,InputResponse,Nada,IoFailure>;

@:using(stx.coroutine.pack.Tunnel.TunnelLift)
@:using(stx.io.Input.InputLift)
@:callable @:forward abstract Input(InputDef) from InputDef to InputDef{

  public inline function new(self:InputDef){
    this = self;
  } 
  @:noUsing static public function make0(ipt:StdIn){
    return new Input(ipt.reply());
  }
  @:noUsing static public function lift(self:InputDef):Input return new Input(self);

  #if (sys || nodejs)
  static public function Keyboard(shell:ShellApi):Input{
    return lift(sys.stx.io.input.term.Keyboard.make(shell));
  }
  #end
  @:from static public function fromTunnel(self:Tunnel<InputRequest,InputResponse,IoFailure>){
    return lift(self.prj());
  }
  public function provide(req:InputRequest){
    return lift(this.provide(req));
  }
  public function prj():InputDef return this;
  private var self(get,never):Input;
  private function get_self():Input return lift(this);
}
class InputLift{
  static public function mandate(self:InputDef,req:InputRequest,fn:Upshot<InputResponse,IoFailure> -> Void):Input{
    final source  = Pledge.trigger();
    var sent      = false;
    var done      = false;
    function f(self:InputDef):InputDef{
      return switch(self){
        case Emit(o,next)               : 
          if(sent){
            if(!done){
              done = true;
              fn(__.accept(o));
            }
            next;
          }else{
            __.emit(o,f(next));
          }
        case Wait(tran)                 : 
          if(!sent){
            sent = true;
            f(tran(req));
          }else{
            __.wait(tran.mod(f));
          }
        case Hold(held)                 :
          __.hold(held.mod(f));
        case Halt(Production(_))    : 
          if(!done){
            __.term(__.fault().of(E_Io_Exhausted(Retry.unit(),true)));
          }else{
            __.prod(Nada);
          } 
        case Halt(Terminated(Stop))     : __.stop();
        case Halt(Terminated(Exit(e)))  : __.exit(e);
      }
    }
    return Input.lift(f(self));
  }  
}