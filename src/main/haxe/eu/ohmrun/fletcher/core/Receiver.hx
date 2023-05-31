package eu.ohmrun.fletcher.core;

typedef ReceiverCls<R,E> = ContCls<ReceiverInput<R,E>,Work>;
typedef ReceiverApi<R,E> = ContApi<ReceiverInput<R,E>,Work>;
typedef ReceiverDef<R,E> = Cont<ReceiverInput<R,E>,Work>;

/**
 * Represents an acceptable output from a `Fletcher`
 */
//@:using(stx.fp.Continuation.ContinuationLift)
@:using(eu.ohmrun.fletcher.core.Receiver.ReceiverLift)
@:forward(apply) abstract Receiver<R,E>(ReceiverApi<R,E>) to ReceiverApi<R,E>{
  static public var _(default,never) = ReceiverLift;
  public function reply():Work{
    return this.apply(ReceiverSink.unit());
  }
  static inline public function lift<R,E>(self:ReceiverApi<R,E>) return new Receiver(self);

  private inline function new(self:ReceiverApi<R,E>) this = self;

  @:noUsing static public function issue<R,E>(outcome:Outcome<R,Defect<E>>,?pos:Pos):Receiver<R,E>{
    return new Receiver(
      Cont.Anon((fn:Apply<ReceiverInput<R,E>,Work>) -> {
        var t = Future.trigger();
            t.trigger(outcome);
        return fn.apply(t.asFuture());
      })
    );
  }
  @:noUsing static public inline function thunk<R,E>(self:Void->Receiver<R,E>,?pos:Pos):Receiver<R,E>{
    return lift(new eu.ohmrun.fletcher.receiver.term.Thunk(self));
  }
  @:noUsing static public inline function value<R,E>(r:R,?pos:Pos):Receiver<R,E>{
    return issue(__.success(r));
  }
  @:noUsing static public inline function error<R,E>(err:Defect<E>,?pos:Pos):Receiver<R,E>{
    return issue(__.failure(err));
  }
  @:noUsing static public inline function later<R,E>(ft:Future<Outcome<R,Defect<E>>>,?pos:Pos):Receiver<R,E>{
    return Receiver.lift(Cont.Anon((fn:ReceiverSinkApi<R,E>) -> fn.apply(ft)));
  }
  public inline function serve():Work{
    return reply();
  }
  public function toString(){
    return 'Receiver($this)';
  }
  public function prj():ReceiverApi<R,E>{
    return this;
  }
}
class ReceiverLift{
  // static public function defer<P,Pi,E,EE>(self:ReceiverApi<P,E>,that:Receiver<Pi,EE>):Receiver<P,E>{
  //   return Receiver.lift(
  //     Cont.AnonAnon(
  //       (f:ReceiverInput<P,E>->Work) -> {
  //         var lhs = that.reply();
  //         //__.log().debug("lhs called"); 
  //         return lhs.seq(Receiver.lift(self).apply(Apply.Anon(f)));
  //       }
  //     )
  //   );
  // }
  // @:noUsing static public function defer<R,E>(self:Void->Receiver<R,E>):Receiver<R,E>{
  //   return Receiver.lift(
  //     Cont.AnonAnon((fn:ReceiverInput<R,E>->Work) -> {
  //       return self().apply(Apply.Anon(fn));
  //     })
  //   );
  // }
  static function lift<P,E>(self:ReceiverApi<P,E>):Receiver<P,E>{
    return Receiver.lift(self);
  }
  static public function flat_fold<P,Pi,E>(self:ReceiverApi<P,E>,ok:P->Receiver<Pi,E>,no:Defect<E>->Receiver<Pi,E>):Receiver<Pi,E>{
    final uuid = __.uuid('xxxx');
    __.log().trace('set up flat_fold: $uuid');
    return Receiver.lift(
      Cont.Anon((cont : Apply<ReceiverInput<Pi,E>,Work>) -> {
        __.log().trace('call flat_fold $uuid');
        return Receiver.lift(self).apply(
          Apply.Anon(
            (p:ReceiverInput<P,E>) -> {
              __.log().trace('inside flat_fold $uuid');
              return Work.fromFutureWork(p.flatMap(
                (out:Outcome<P,Defect<E>>) -> {
                  __.log().trace('flat_fold:end $uuid');
                  return out.fold(ok,no);
                }
              ).flatMap(
                (rec:Receiver<Pi,E>) -> {
                  return rec.apply(cont);
                }
              ));
          })
        );
      }
    ));
  }
  static public function map<P,Pi,E>(self:ReceiverApi<P,E>,fn:P->Pi):Receiver<Pi,E>{
    return Receiver.lift(Cont._.map(
      self,
      out -> out.map(x -> x.map(fn))
    ));
  }
  static public function flat_map<P,Pi,E>(self:ReceiverApi<P,E>,fn:P->Receiver<Pi,E>):Receiver<Pi,E>{
    return flat_fold(
      self,
      fn,
      e -> Receiver.issue(Failure(e))
    );
  }
  static public function tap<P,Pi,E>(self:ReceiverApi<P,E>,fn:P->Void):Receiver<P,E>{
    return map(self,__.nano().command(fn));
  }
  static public function fold_bind<P,Pi,E,EE>(self:ReceiverApi<P,E>,ok:P->ReceiverInput<Pi,EE>,no:Defect<E>->ReceiverInput<Pi,EE>):Receiver<Pi,EE>{
    return Receiver.lift(
      Cont.Anon(
        (cont:Apply<ReceiverInput<Pi,EE>,Work>) -> Receiver.lift(self).apply(
          Apply.Anon((p:ReceiverInput<P,E>) -> cont.apply(
            p.fold_bind(
              ok,
              no
            )
          )
        )
    )));
  }
  static public function fold_mapp<P,Pi,E,EE>(self:ReceiverApi<P,E>,ok:P->ArwOut<Pi,EE>,no:Defect<E>->ArwOut<Pi,EE>):Receiver<Pi,EE>{
    return Receiver.lift(
      Cont.Anon(
        (cont:Apply<ReceiverInput<Pi,EE>,Work>) -> Receiver.lift(self).apply(
          Apply.Anon(
            (p:ReceiverInput<P,E>) -> cont.apply(
              p.fold_mapp(
                ok,
                no
              )
            )
          )
        )
      )
    );
  }
  static public function mod<P,E>(self:ReceiverApi<P,E>,g:Work->Work):Receiver<P,E>{
    return lift(Cont.Mod(self,g));
  }
  static public function zip<Pi,Pii,E>(self:ReceiverApi<Pi,E>,that:Receiver<Pii,E>):Receiver<Couple<Pi,Pii>,E>{
    return Receiver.lift(
      Cont.Anon((f:Apply<ReceiverInput<Couple<Pi,Pii>,E>,Work>) -> {
        var lhs        = null;
        var rhs        = null;
        var work_left  = Receiver.lift(self).apply(
          Apply.Anon((ocI)   -> {
            lhs = ocI;
            return Work.unit();
          })
        );
        var work_right = that.apply(
          Apply.Anon((ocII)  -> {
            rhs = ocII;
            return Work.unit();
          })
        );
        return work_left.par(work_right).seq(
          Future.irreversible(
            (cb:Work->Void) -> {
              //trace('par');
              var ipt        = lhs.zip(rhs);
              var res        = f.apply(ipt);
              cb(res);
            }
          )
        );
      }
    ));
  }
  static public function errata<P,E,EE>(self:ReceiverApi<P,E>,fn:Defect<E>->Defect<EE>){
    return fold_mapp(
      self,
      (p) -> __.success(p),
      (e) -> __.failure(fn(e))      
    );
  }
  static public function errate<P,E,EE>(self:ReceiverApi<P,E>,fn:E->EE){
    return errata(self,x -> x.errate(fn));
  }
}