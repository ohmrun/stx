package stx.nano;

typedef AlertDef<E> = Future<Report<E>>;

@:using(stx.nano.Alert.AlertLift)
@:forward abstract Alert<E>(AlertDef<E>) from AlertDef<E> to AlertDef<E>{
  @:noUsing static public function trigger() {
    return new AlertTrigger();
  }
  
  @:noUsing static public function unit<E>():Alert<E>{
    return Future.irreversible((cb) -> cb(Report.unit()));
  }
  @:noUsing static public function pure<E>(e:Error<E>):Alert<E>{
    return Future.irreversible((cb) -> cb(Report.pure(e)));
  }
  @:noUsing static public function make<E>(self:Report<E>):Alert<E>{
    return Future.irreversible((cb) -> cb(self));
  }
  //TODO not sure about this
  static public function any<E>(arr:Cluster<Alert<E>>):Alert<E>{
    return lift(new stx.nano.module.Future().bind_fold(
      arr,
      (next:Alert<E>,memo:Report<E>) -> next.prj().map(
        (report:Report<E>) -> memo.concat(report)
      ),
      Report.unit()
    ));
  }
  static public function seq<T,E>(arr:Cluster<T>,fn:T->Alert<E>):Alert<E>{
    return lift(
      new stx.nano.module.Future().bind_fold(
        arr,
        (next:T,memo:Report<E>) -> memo.fold(
          (err) -> Alert.pure(err),
          ()    -> fn(next)
        ),
        Report.unit()
      )
    );
  }
  public function new(self) this = self;
  @:noUsing static public function lift<E>(self:AlertDef<E>):Alert<E> return new Alert(self);

  public function prj():AlertDef<E> return this;
  private var self(get,never):Alert<E>;
  private function get_self():Alert<E> return lift(this);

  public function errata<EE>(fn:E->EE):Alert<EE>{
    return AlertLift.flat_fold(this,(err) -> Alert.pure(err.errata(fn)),() -> Alert.unit());
  }
  public function handle(fn:Report<E>->Void):CallbackLink{
    return this.handle(fn);
  }
}
class AlertLift{
  static public function fold<E,Z>(self:AlertDef<E>,pure:Error<E>->Z,unit:Void->Z):Future<Z>{
    return self.map(
      report -> report.fold(pure,unit)
    );
  }
  static public function execute<E>(self:AlertDef<E>,fn:Void->Alert<E>):Alert<E>{
    return self.flatMap(
      report -> report.fold(
        err -> Alert.pure(err),
        ()  -> fn()
      )
    );
  }
  static public function adjust<E>(self:AlertDef<E>,fn:Report<E>->Alert<E>):Alert<E>{
    return Alert.lift(
      self.flatMap(
        (report) -> fn(report)
      ) 
    );
  }
  static public function tap<E>(self:AlertDef<E>,fn:Report<E>->?Pos->Void,?pos:Pos):Alert<E>{
    return Alert.lift(self.map(
      (report) -> {
        fn(report,pos);
        return report;
      }
    ));
  }
  static public function flat_fold<E,T>(self:AlertDef<E>,ers:Error<E>->Future<T>,nil:Void->Future<T>):Future<T>{
    return self.flatMap(
      (report) -> report.fold(
        ers,
        nil
      )
    );
  }
  static public function resolve<E,T>(self:AlertDef<E>,val:T):Pledge<T,E>{
    return Pledge.lift(fold(self,(e) -> stx.nano.Upshot.UpshotSum.Reject(e),() -> Accept(val)));
  }
  static public function ignore<E>(self:AlertDef<E>,?fn:Lapse<E>->Bool):Alert<E>{
    return Alert.lift(self.map(
      (report:Report<E>) -> report.ignore(fn)
    ));
  }
  static public function anyway<E>(self:AlertDef<E>,fn:Report<E>->Alert<E>):Alert<E>{
    return self.flatMap(
      (report) -> fn(report).prj()
    );
  }
  // static public function toTinkPromise<E>(self:AlertDef<E>):tink.core.Promise<Nada>{
  //   return fold(
  //     self,
  //     er -> tink.core.Outcome.Failure(er.toTinkError()),
  //     () -> tink.core.Outcome.Success(Nada)
  //   );
  // }
  static public function zip<E>(self:AlertDef<E>,that:Alert<E>):Alert<E>{
    var out = new stx.nano.module.Future().zip(self,that.prj()).map(
      (tp) -> tp.fst().concat(tp.snd())
    );
    return out;
  }
}
@:forward abstract AlertTrigger<E>(FutureTrigger<Report<E>>) from FutureTrigger<Report<E>> to FutureTrigger<Report<E>>{
  public function new(){
    this = Future.trigger();
  }  

}