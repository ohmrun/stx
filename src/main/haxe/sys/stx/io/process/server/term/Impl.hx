package sys.stx.io.process.server.term;

import stx.io.StdIn  in AsysStdIn;
import stx.io.StdOut in AsysStdOut;

/**
  Default implementation of ProcessServer using the internal stdin/stdout.
**/
#if (sys || nodejs)
class Impl{
  private var proc                  : sys.io.Process;
  private var stdin                 : Output;
  private var stdout                : Input;
  private var stderr                : Input;

  public var state(default,null)    : ProcessState;

  @:noUsing static public function makeI(command:Cluster<String>,?detached:Bool):Impl{
    __.log().debug(command.join(" "));
    final proc                        = new sys.io.Process(command.head().fudge(), Std.downcast(command.tail(),Array),detached);
    final ins   : Output              = AsysStdOut.lift(proc.stdin).reply();
    final outs  : Input               = AsysStdIn.lift(proc.stdout).reply();
    final errs  : Input               = AsysStdIn.lift(proc.stderr).reply();    
    return new Impl(proc, ins, outs, errs);
  }
  public function new(proc:sys.io.Process,stdin:Output,stdout:Input,stderr:Input,?state:ProcessState){
    this.proc   = proc;
    this.stdin  = stdin;
    this.stdout = stdout;
    this.stderr = stderr; 
    this.state  = __.option(state).defv(ProcessState.make(Io_Process_Init));
  }
  private function get_state(?block = false){
    __.log().debug('get_state');
    this.stdout = this.stdout.mandate(
      IReqState,
      (res) -> {
        switch(res){
          case Accept(IResState(s)) : 
            this.state = this.state.with_stdout(s);
          case Reject(err)          : 
            this.state = this.state.with_stdout(Io_Input_Error(err));
          default                   : 
            this.state = this.state.with_stdout(Io_Input_Error(__.fault().of(E_Io_UnsupportedValue)));
        }
      }
    );
    this.stderr  = this.stderr.mandate(
      IReqState,
      (res) -> {
        switch(res){
          case Accept(IResState(s)) : 
            this.state = this.state.with_stderr(s);
          case Reject(err)          : 
            this.state = this.state.with_stderr(Io_Input_Error(err));
          default                   : 
            this.state = this.state.with_stderr(Io_Input_Error(__.fault().of(E_Io_UnsupportedValue)));
        }
      }
    );
    this.state = this.state.with_exit_code(
      #if interp
        ExitCode.unit()
      #else
        ExitCode.lift(proc.exitCode(block))
      #end
    );
  }
  public function reply():ProcessServerDef{
    __.log().trace('reply');
    return __.yield(
      PResState(this.state),
      function rec(req:ProcessRequest){
        __.log().trace(_ -> _.thunk(() -> '$req ${this.state}'));
        return switch(this.state){
          case { status : ( Io_Process_Init | Io_Process_Open ) } :
            switch(req){
              case PReqTouch                : reply();
              case PReqState(block)         : 
                get_state(block);
                reply();
              case PReqInput(req,false)     : 
                final source = Future.trigger();
                this.stdout  = stdout.mandate(
                  req,
                  res -> res.fold(
                    ok -> source.trigger(__.yield(PResValue(Success(ok)),rec)),
                    no -> source.trigger(__.ended(End(no.errata(E_Process_Io))))
                  )
                );
                __.belay(Belay.fromFuture(() -> source.asFuture()));
              case PReqInput(req,true)      : 
                final source = Future.trigger();
                this.stderr  = stderr.mandate(
                  req,
                  res -> res.fold(
                    ok -> source.trigger(__.yield(PResValue(Failure(ok)),rec)),
                    no -> source.trigger(__.ended(End(no.errata(E_Process_Io))))
                  )
                );
                __.belay(Belay.fromFuture(() -> source.asFuture()));
              case PReqOutput(req)          : 
                this.stdin  = stdin.provide(req);
                reply();
            }
          case { status : x } :
            __.yield(PResState(this.state),rec);
        }
      }
    );
  }
}
#end