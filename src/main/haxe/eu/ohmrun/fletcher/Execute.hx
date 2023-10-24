package eu.ohmrun.fletcher;

typedef ExecuteDef<E>                   = FletcherDef<Nada,Report<E>,Nada>;

@:using(eu.ohmrun.fletcher.Execute.ExecuteLift)
abstract Execute<E>(ExecuteDef<E>) from ExecuteDef<E> to ExecuteDef<E>{
  public inline function new(self) this = self;
  @:noUsing static public inline function lift<E>(self:ExecuteDef<E>):Execute<E> return new Execute(self);
  @:noUsing static public inline function pure<E>(e:Refuse<E>):Execute<E> return lift(Fletcher.pure(Report.pure(e)));
  @:noUsing static public inline function unit<E>():Execute<E> return lift(Fletcher.pure(Report.unit()));

  static public function context<E>(stream:Stream<Execute<E>,E>):Execute<E>{
    var buffer = [];
    var report = __.report();
    stream.handle(
      x -> x.fold(
        ok -> { buffer.push(ok);            null; },
        e  -> { report = __.report(_ -> e); null; },
        () -> {}
      )
    );
    return fromFunXExecute(
      () -> {
        final window = buffer.copy();
        buffer = [];
        return report.fold(
          e   -> Execute.fromRefuse(e),
          ()  -> Execute.sequence(x -> x,window)
        );
      }
    );
  }
  /**
   * @param fn 
   * @return Execute<E>
   */
  @:noUsing static public function bind_fold<T,E>(fn:T->Report<E>->Execute<E>,arr:Iterable<T>):Execute<E>{
    return (arr:Iter<T>).lfold(
      (next:T,memo:Execute<E>) -> Execute.lift(Provide._.flat_map(
        memo,
        (report) -> lift(fn(next,report))
      )),
      unit()
    );
  }  
  @:noUsing static public function sequence<T,E>(fn:T->Execute<E>,arr:Iterable<T>):Execute<E>{
    return (arr:Iter<T>).lfold(
      (next:T,memo:Execute<E>) -> Execute.lift(
        memo.fold_mod(
          (report:Report<E>) -> report.fold(
            (e)-> Execute.pure(e),
            () -> fn(next)
          )
        )
      ),
      unit()
    );
  }
  @:to public function toProvide():Provide<Report<E>>{
    return this;
  }
  @:to public inline function toFletcher():Fletcher<Nada,Report<E>,Nada>{
    return this;
  }
  @:from static public function fromFunXR<E>(fn:Void->Report<E>):Execute<E>{
    return lift(Fletcher.fromFunXR(fn));
  }
  @:from static public function fromThunk<E>(fn:Void->Void):Execute<E>{
    return fromFunXR(()  -> {
      fn();
      return __.report();
    });
  }
  @:from static public function fromFunXExecute<E>(fn:Void->Execute<E>):Execute<E>{
    return fn();
  }
  public function prj():ExecuteDef<E> return this;
  private var self(get,never):Execute<E>;
  private function get_self():Execute<E> return lift(this);

  @:noUsing static public function fromOption<E>(err:Option<Refuse<E>>):Execute<E>{
    return fromFunXR(() -> Report.fromOption(err));
  }
  @:noUsing static public function fromRefuse<E>(err:Refuse<E>):Execute<E>{
    return fromFunXR(() -> Report.pure(err));
  }
  public function environment(?success:Void->Void,?failure:Refuse<E>->Void,?pos:Pos){
    __.log().trace('execute environment ${(pos:Position)}');
    if(success == null){
      success = () -> __.log().info('execute complete');
    } 
    if(failure == null){
      failure = (e) -> e.report();
    }
    return Fletcher._.environment(
      this,
      Nada,
      (report) -> {
        __.log().trace(_ -> _.thunk(() -> 'report'));
        report.fold(
          failure,
          success
        );
      },
      __.crack,
      pos
    );
  }
}
class ExecuteLift{
  static public function errata<E,EE>(self:Execute<E>,fn:Refuse<E>->Refuse<EE>):Execute<EE>{
    return Execute.lift(self.toFletcher().then(
      Fletcher.Sync((report:Report<E>) -> report.errata(fn))
    ));
  }
  static public function errate<E,EE>(self:Execute<E>,fn:E->EE):Execute<EE>{
    return Execute.lift(self.toFletcher().then(
      Fletcher.Sync((report:Report<E>) -> report.errata(
        (e:Refuse<E>) -> e.errate(fn)
      ))
    ));

  }
  static public function deliver<E>(self:Execute<E>,fn:Report<E>->Void):Fiber{
    return Fletcher.Then(
      Fletcher.lift(self),
      Fletcher.Sync(
        (report) -> {
          fn(report);
          return Nada;
        }
      )
    );
  }
  static public function crack<E>(self:Execute<E>):Fiber{
    return deliver(self,
      (report) -> report.fold(
        __.crack,
        () -> {}
      )
    );
  }
  static public function then<E,O>(self:ExecuteDef<E>,that:Fletcher<Report<E>,O,Nada>):Provide<O>{
    return Provide.lift(Fletcher.Then(
      self,
      that
    ));
  }
  static public function execute<E,O>(self:ExecuteDef<E>,next:Execute<E>):Execute<E>{
    return Execute.lift(Fletcher.Then(
      self,
      Fletcher.Anon(
        (ipt:Report<E>,cont:Terminal<Report<E>,Nada>) -> ipt.fold(
          (e) -> cont.receive(cont.value(Report.pure(e))),
          ()  -> cont.receive(next.forward(Nada))
        )
      )
    ));
  }
  static public function produce<E,O>(self:ExecuteDef<E>,next:Produce<O,E>):Produce<O,E>{
    return Produce.lift(
      Fletcher.Then(
        self,
        Fletcher.Anon(
          (ipt:Report<E>,cont:Waypoint<O,E>) -> ipt.fold(
            (e) -> cont.receive(cont.value(__.reject(e))),
            ()  -> cont.receive(next.forward(Nada))
          )
        )
      )
    );
  }
  static public function propose<E,O>(self:ExecuteDef<E>,next:Propose<O,E>):Propose<O,E>{
    return Propose.lift(
      Fletcher.Then(
        self,
        Fletcher.Anon(
          (ipt:Report<E>,cont:Terminal<Chunk<O,E>,Nada>) -> ipt.fold(
            (e) -> cont.receive(cont.value(End(e))),
            ()  -> cont.receive(next.forward(Nada))
          )
        )
      )
    );
  }
  static public function fold_mod<E,EE,O>(self:ExecuteDef<E>,fn:Report<E>->Execute<EE>):Execute<EE>{
    return Execute.lift(
      Fletcher.FlatMap(
        Fletcher.lift(self),
        (report:Report<E>) -> fn(report).toFletcher()
      )
    );
  }
  static public function and<E>(self:Execute<E>,that:Execute<E>):Execute<E>{
    return self.execute(that);
  }
  static public function alert<E>(self:Execute<E>):Alert<E>{
    final trigger = Future.trigger();
    return Alert.lift(self.deliver(
      (report) -> {
        trigger.trigger(report);
      }
    ).reply().flatMap(
      (_) -> trigger.asFuture()
    ));
  }
}