package stx.sys.cli.application.spec;

class SpecItemParser extends ParserCls<CliToken,SpecValue>{
  public final delegate : SpecValue;

  public function new(delegate:SpecValue){
    super();
    this.delegate = delegate;
  }
  override public function apply(ipt:ParseInput<CliToken>){
    __.log().trace('item ${this.delegate}');
    __.log().trace('${ipt.head()}');
    final is_greedy = !delegate.rest.is_defined() && delegate.spec.config.greedy;
    
    return switch(ipt.head()){
      case Val(Arg(x)) : 
        delegate.get_section(x).fold(
          (ok) -> {
            __.log().trace('delegate section: $ok');
            final missing_options = delegate.get_missing_options();
            return missing_options.is_defined().if_else(
              () -> ipt.digest('missing options: $missing_options'),
              () -> {
                final missing_arguments = delegate.get_missing_arguments();
                return missing_arguments.is_defined().if_else(
                  () -> ipt.digest('missing arguments: $missing_arguments'),
                  () -> {
                    __.log().trace('subsection');
                    final next_spec_parser = SpecParser.makeI(new SpecValue(ok,[],[],None)).asParser();
                    return next_spec_parser.then(
                      (subspec) -> {
                        return delegate.with_rest(Some(subspec));
                      }
                    ).apply(ipt.tail());
                  }
                );
              }
            );
          },
          () -> {
            __.log().trace('${delegate.args}');
            return delegate.get_arg().fold(
              (y) -> {
                final with_arg = delegate.with_arg(y.with(x));
                return ipt.tail().ok(with_arg);
              },
              () -> {
                return if(is_greedy){
                  final arg_spec = new ArgumentSpec(x,'automatically added',false);
                  final with_arg = delegate.with_arg(arg_spec.with(x));
                  ipt.tail().ok(with_arg);
                }else{
                  delegate.is_args_full().if_else(
                    () -> ipt.no(E_Parse_ExtraArgument),
                    () -> ipt.no(E_Parse_ExtraArgument)
                  );
                }
              }
            );
          }
        );
      case Val(Opt(string)) : 
        switch(delegate.args.is_defined()){
          case true  : 
            __.log().trace('${delegate.args}');
            __.log().trace(string);
            ipt.digest("no options should be defined after arguments");
          case false :
            __.log().trace(string);
            delegate.get_opt(string).fold(
              (opt:OptionSpecApi) -> {
                __.log().trace('${opt.kind}');
                return switch(opt.kind){
                  case PropertyKind(false) : delegate.get_opt_value(opt).fold(
                    ok -> ipt.digest('${opt.name} already defined'),
                    () -> {  
                      final opt_val = opt.with(None);
                      return opt_val.is_assignment().if_else(
                        () -> ipt.tail().ok(delegate.with_opt(opt_val)),
                        () -> (opt.kind == FlagKind).if_else(
                          () -> ipt.tail().ok(delegate.with_opt(opt_val)),
                          () -> switch(ipt.tail().head()){
                            case Val(Arg(x)) : 
                              ipt.tail().tail().ok(
                                delegate.with_opt(opt.with(Some(x)))
                              );
                            default     : ipt.digest('$opt requires value');
                          }
                        )
                      );
                    }
                  );
                  case PropertyKind(true) : 
                    final opt_val = opt.with(Some(string));
                    __.log().trace(opt_val.is_assignment());
                    return opt_val.is_assignment().if_else(
                      () -> ipt.tail().ok(delegate.with_opt(opt.with_assignment(string))),
                      () -> (opt.kind == FlagKind).if_else(
                        () -> ipt.tail().ok(delegate.with_opt(opt_val)),
                        () -> switch(ipt.tail().head()){
                          case Val(Arg(x)) : ipt.tail().tail().ok(
                            delegate.with_opt(opt.with(Some(x)))
                          );
                          default     : ipt.digest('$opt requires value');
                        }
                      )
                    );
                  case ArgumentKind : ipt.except('option defined as argument');
                  case FlagKind     :  
                    delegate.get_opt_value(opt).fold(
                      ok -> ipt.digest('${opt.name} already defined'),
                      () -> {
                        final opt_val = opt.with(None);
                        return ipt.tail().ok(delegate.with_opt(opt_val));
                      }
                    );
                }
              },
              () -> if(is_greedy){
                final opt_type : Upshot<OptionKind,CliFailure> = switch(ipt.tail().head()){
                  case Val(Arg(_)) : __.accept(PropertyKind(true));
                  case Val(Opt(_)) :
                    final opt      = new stx.sys.cli.application.spec.term.PropertyWildcard(string,'auto property',PropertyKind(true),false); 
                    final opt_val = opt.with(Some(string));
                    if(opt_val.is_assignment()){
                      __.accept(PropertyKind(true));
                    }else{
                      __.accept(FlagKind);
                    }
                  case End(null)  : 
                    __.reject(
                      f -> f.of(
                        E_Cli_ParseError(
                          ipt.except('empty End chunk',f.toPos()).error
                        )
                      )
                  );
                  case End(e)     :
                    e.lapse.toIter().search(
                      (x:Lapse<ParseFailure>) -> {
                        return x.value == EOF;
                      }
                    ).is_defined().if_else(
                      () -> __.reject(
                        f -> f.of(E_Cli_ParseError(
                          ipt.tail().eof().error
                          )
                        )
                      ),
                      () -> __.reject(f -> e)
                    );
                  case x : 
                    __.log().error('$x');
                    __.reject(f -> f.of(E_Cli('Incorrect value')));
                }
                switch(opt_type){
                  case Accept(PropertyKind(_)) : 
                    final opt      = new stx.sys.cli.application.spec.term.PropertyWildcard(string,'auto property',PropertyKind(true),false); 
                    final opt_val = opt.with(None);
                    opt_val.is_assignment().if_else(
                      () -> ipt.tail().ok(delegate.with_opt(opt_val)),
                      () ->  switch(ipt.tail().head()){
                        case Val(Arg(x)) : 
                          ipt.tail().tail().ok(
                            delegate.with_opt(opt.with(Some(x)))
                          );
                        default     : ipt.except('$opt requires value');
                      }
                    );
                  case Accept(FlagKind) : 
                    final opt      = new stx.sys.cli.application.spec.term.PropertyWildcard(string,'auto property',FlagKind,false); 
                    ipt.tail().ok(delegate.with_opt(opt.with(None)));
                  case Reject(e)        : 
                    // $type(e);
                    final result =  e.lapse.toIter().search(
                        (l:Lapse<CliFailure>) -> EnumValue.lift(l.value).alike(E_Cli_Parse(null))
                      ).flat_map(
                        (x:Lapse<CliFailure>) -> switch(x.value){
                          case E_Cli_Parse(x) :__.option(x);
                          default             : None;
                        }
                      ).map(
                          (e:ParseFailure) -> {
                            return ParseResult.make(
                              ipt.tail(),
                              None,
                              ErrorCtr.instance.Value(
                                e,
                                _ -> LocCtr.instance.Available().with_cursor(@:privateAccess ipt.tail().content.index)
                              )
                            );
                          }
                        ).defv(
                          ipt.except('weird condition error')
                        ); 
                    result;
                  
                  case x : 
                    __.log().fatal(_ -> _.thunk(() -> '$x'));
                    ipt.except('weird condition error');
                }
              }else{
                ipt.except('no option "$string" found');
              }
            );
        } 
      default : ipt.ok(delegate);
    }
  }
}