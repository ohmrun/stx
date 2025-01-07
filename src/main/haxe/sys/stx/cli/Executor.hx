package sys.stx.cli;

class Executor extends Clazz{
  public function execute(res:Upshot<CliContext,CliFailure>){
    switch(res){
      case Accept(ok) : __.log().debug(ok.info());
      case Reject(e)  : __.log().debug('$e');
    }
    return @:privateAccess (sys.stx.cli.react.Main.handlers.lfold(
      (next:ProgramApi,memo:Unary<Upshot<CliContext,CliFailure>,Agenda<CliFailure>>) -> {  
        __.log().trace('$next');
          return memo.apply.fn().then(
            (x:Agenda<CliFailure>) -> {
              __.log().debug('${x.error}');
              final is_that_not_implementation = x.error.option().flat_map(e -> e.lapse.first()).map(
                x -> new EnumValue(x.value).alike(E_Cli_NoImplementation)
              ).defv(false);
              return if(is_that_not_implementation){
                next.apply(res);
              }else{
                x;
              }
              // return x.error.fold(
              //   no -> switch(no.data){
              //     case Some(EXTERNAL(E_Cli_NoImplementation))   : 
              //       __.log().debug(_ -> _.pure(next));
              //       next.apply(res);
              //     default                                 : x;
              //   },
              //   () -> x  
              // );
            }
          );
        },
        x -> Agenda.lift(__.ended(End(__.fault().of(E_Cli_NoImplementation))))
    ))(res).toExecute();
  }
}