package eu.ohmrun.fletcher;

enum ProduceArgSum<O,E>{
  ProduceArgPure(o:O);
  ProduceArgSync(res:Upshot<O,E>);
  ProduceArgThunk(fn:Thunk<Upshot<O,E>>);
  ProduceArgRefuse(Refuse:Refuse<E>);
  ProduceArgPledge(pledge:Pledge<O,E>);
  ProduceArgFunXProduce(fn:Void->Produce<O,E>);
  ProduceArgFletcher(fletcher:Fletcher<Nada,O,E>);
}
abstract ProduceArg<O,E>(ProduceArgSum<O,E>) from ProduceArgSum<O,E> to ProduceArgSum<O,E>{
  public function new(self) this = self;
  static public function lift<O,E>(self:ProduceArgSum<O,E>):ProduceArg<O,E> return new ProduceArg(self);

  public function prj():ProduceArgSum<O,E> return this;
  private var self(get,never):ProduceArg<O,E>;
  private function get_self():ProduceArg<O,E> return lift(this);
  
  @:from static public function fromFunXProduce<O,E>(fn:Void->Produce<O,E>):ProduceArg<O,E>{
    return ProduceArgFunXProduce(fn);
  }
  @:from static public function fromFletcher<O,E>(fletcher:Fletcher<Nada,O,E>):ProduceArg<O,E>{
    return ProduceArgFletcher(fletcher);
  }
  @:from static public function fromPledge<O,E>(pledge:Pledge<O,E>):ProduceArg<O,E>{
    return ProduceArgPledge(pledge);
  }
  @:from static public function fromFuture<O,E>(self:Future<O>):ProduceArg<O,E>{
    return ProduceArgPledge(Pledge.lift(self.map(__.accept)));
  }
  @:from static public function fromRefuse<O,E>(Refuse:Refuse<E>):ProduceArg<O,E>{
    return ProduceArgRefuse(Refuse);
  }
  @:from static public function fromThunk<O,E>(fn:Thunk<Upshot<O,E>>):ProduceArg<O,E>{
    return ProduceArgThunk(fn);
  }
  @:from static public function fromSync<O,E>(res:Upshot<O,E>):ProduceArg<O,E>{
    return ProduceArgSync(res);
  }
  @:from static public function fromPure<O,E>(o:O):ProduceArg<O,E>{
    return ProduceArgPure(o);
  }
}
typedef ProduceDef<O,E> = FletcherDef<Nada,Upshot<O,E>,Nada>;

@:using(eu.ohmrun.fletcher.Produce.ProduceLift)
@:forward(then) abstract Produce<O,E>(ProduceDef<O,E>) from ProduceDef<O,E> to ProduceDef<O,E>{
  static public var _(default,never) = ProduceLift;

  public inline function new(self:ProduceDef<O,E>) this = self;

  @:noUsing static public inline function lift<O,E>(self:ProduceDef<O,E>):Produce<O,E> return new Produce(self);

  @:noUsing static public inline function bump<O,E>(self:ProduceArg<O,E>):Produce<O,E>{
    return switch(self){
      case ProduceArgPure(o)              : pure(o);
      case ProduceArgSync(res)            : Sync(res);
      case ProduceArgThunk(fn)            : Thunk(fn);
      case ProduceArgRefuse(refuse)       : fromRefuse(refuse);
      case ProduceArgPledge(pledge)       : fromPledge(pledge);
      case ProduceArgFunXProduce(fn)      : fromFunXProduce(fn);
      case ProduceArgFletcher(fletcher)   : fromFletcher(fletcher);
    }
  }
  @:noUsing static public function Sync<O,E>(result:Upshot<O,E>):Produce<O,E>{
    return Produce.lift(
      Fletcher.Anon((_:Nada,cont) -> cont.receive(cont.value(result)))
    );
  }
  @:noUsing static public function Thunk<O,E>(result:Thunk<Upshot<O,E>>):Produce<O,E>{
    return Produce.lift(
      Fletcher.Anon((_:Nada,cont) -> cont.receive(cont.value(result())))
    );
  }
  @:from @:noUsing static public function fromFunXProduce<O,E>(self:Void->Produce<O,E>):Produce<O,E>{
    return lift(Fletcher.Anon(
      (_:Nada,cont:Terminal<Upshot<O,E>,Nada>) -> cont.receive(self().forward(Nada))
    ));
  }
  @:noUsing static public function fromRefuse<O,E>(e:Refuse<E>):Produce<O,E>{
    return Sync(__.reject(e));
  }
  @:noUsing static public function pure<O,E>(v:O):Produce<O,E>{
    return Sync(__.accept(v));
  }
  @:noUsing static public function accept<O,E>(v:O):Produce<O,E>{
    return Sync(__.accept(v));
  }
  @:noUsing static public function reject<O,E>(e:Refuse<E>):Produce<O,E>{
    return Sync(__.reject(e));
  }
  @:from @:noUsing static public function fromUpshot<O,E>(res:Upshot<O,E>):Produce<O,E>{
    return Sync(res);
  }
  @:from @:noUsing static public function fromFunXUpshot<O,E>(fn:Void->Upshot<O,E>):Produce<O,E>{
    return Thunk(fn);
  }
  
  @:from @:noUsing static public function fromPledge<O,E>(pl:Pledge<O,E>):Produce<O,E>{
    return lift(
      Fletcher.Anon(      
        (_:Nada,cont:Terminal<Upshot<O,E>,Nada>) -> {
          return cont.receive(cont.later(
            pl.fold(
              (x) -> __.success(__.accept(x)),
              (e) -> __.success(__.reject(e))
            )
          ));
        }
      )
    );
  }
  
  @:noUsing static public function fromFunXR<O,E>(fn:Void->O):Produce<O,E>{
    return lift(
      Fletcher.fromFun1R(
        (_:Nada) -> __.accept(fn())
      )
    ); 
  }
  @:noUsing static public function fromFletcher<O,E>(arw:Fletcher<Nada,O,E>):Produce<O,E>{
    return lift(
      Fletcher.Anon((_:Nada,cont:Waypoint<O,E>) -> cont.receive(
          arw.forward(Nada).fold_mapp(
            (ok:O)          -> __.success(__.accept(ok)),
            (no:Defect<E>)  -> __.success(__.reject(no.toRefuse()))
          )
        )
    ));
  }
  static public function bind_fold<P,O,R,E>(data:Iter<P>,fn:P->R->Produce<R,E>,r:R):Produce<R,E>{
    return data.lfold(
      (next:P,memo:Produce<R,E>) -> {
        return memo.flat_map(
          r -> fn(next,r)
        );
      },
      pure(r)
    );
  }
  static public function parallel<P,O,R,E>(data:Iter<P>,fn:P->Cell<Upshot<R,E>>->Produce<R,E>,r:R):Produce<R,E>{
    return lift(Fletcher.Anon(
      (_:Nada,cont:Waypoint<R,E>) -> {
        var memo                          = r;
        var fail    : Null<Refuse<E>>  = null;
        final cell  = Cell.make(
          () -> fail == null ? __.accept(memo) : __.reject(fail)
        );
        var work        = Work.unit();
        var count       = 0;
        var done        = false;
        final trigger   = Future.trigger();

        for(p in data){
          count = count + 1;
          work = work.par(
            fn(p,cell).environment(
              ok -> {
                if(!done){
                  memo = ok;
                  count = count -1;
                  if(count == 0){
                    done = true;
                    trigger.trigger(__.success(__.accept(memo)));
                  }
                }
              },
              no -> {
                fail = no;
                done = true;
                trigger.trigger(__.success(__.reject(no)));
              }
            ).work()
          );
        }
        return work.par(cont.receive(cont.later(trigger)));
      }
    ));
  }
  static public function fromProvide<O,E>(self:Provide<Upshot<O,E>>):Produce<O,E>{
    return Produce.lift(Fletcher.Anon(
      (_:Nada,cont:Terminal<Upshot<O,E>,Nada>) -> cont.receive(self.forward(Nada))
    ));
  }
  public inline function environment(success:O->Void,?failure:Refuse<E>->Void){
    return _.environment(this,success,failure);
  }
  @:to public inline function toFletcher():Fletcher<Nada,Upshot<O,E>,Nada>{
    return this;
  }
  @:to public function toPropose():Propose<O,E>{
    return Propose.lift(Fletcher._.map(this,(res:Upshot<O,E>) -> res.fold(Val,End)));
  }
  private var self(get,never):Produce<O,E>;
  private function get_self():Produce<O,E> return this;

  public function prj():ProduceDef<O,E>{
    return this;
  }
  public inline function fudge<O,E>(){
    return _.fudge(this);
  }
  public function flat_map<Oi>(fn:O->Produce<Oi,E>):Produce<Oi,E>{
    return _.flat_map(this,fn);
  }
}
class ProduceLift{
  static public inline function environment<O,E>(self:ProduceDef<O,E>,success:O->Void,?failure:Refuse<E>->Void):Fiber{
    failure = failure ?? (e:Refuse<E>) ->  e.crack();
    return Fletcher._.environment(
      self,
      Nada,
      (res:Upshot<O,E>) -> {
        res.fold(success,failure);
      },
      __.crack
    );
  }
  @:noUsing static private function lift<O,E>(self:ProduceDef<O,E>):Produce<O,E> return Produce.lift(self);
  
  static public function map<I,O,Z,E>(self:ProduceDef<O,E>,fn:O->Z):Produce<Z,E>{
    return lift(then(
      self,
      Fletcher.fromFun1R(
        (oc:Upshot<O,E>) -> oc.map(fn)
      )
    ));
  }
  static public function errata<O,E,EE>(self:ProduceDef<O,E>,fn:Refuse<E>->Refuse<EE>):Produce<O,EE>{
    return lift(self.then(
      Fletcher.fromFun1R(
        (oc:Upshot<O,E>) -> oc.errata(fn)
      )
    ));
  }
  static public function errate<O,E,EE>(self:ProduceDef<O,E>,fn:E->EE):Produce<O,EE>{
    return errata(self,(er) -> er.errate(fn));
  }
  /**
    Use the output to create an Execute.
  **/
  static public function point<O,E>(self:ProduceDef<O,E>,success:O->Execute<E>):Execute<E>{
    return Execute.lift(
      Fletcher.Anon(
        (_:Nada,cont:Terminal<Report<E>,Nada>) -> cont.receive(
          self.forward(Nada).flat_fold(
            res -> res.fold(
              ok -> success(ok).forward(Nada),
              er -> cont.value(Report.pure(er))
            ),
            err -> cont.error(err)
          )
        ) 
      )
    );
  }
  static public function provide<O,E>(self:ProduceDef<O,E>):Provide<O>{
    return Provide.lift(
      Fletcher._.map(self,
        res -> res.fold(
          (ok)  -> ok,
          (e)   -> throw(e)
        )
      )
    );
  }
  static public function propose<O,Oi,E>(self:ProduceDef<O,E>,fn:Upshot<O,E>->Propose<Oi,E>):Propose<Oi,E>{
    return Propose.lift(
      Fletcher.Then(
        self,
        Fletcher.Anon(
          (p:Upshot<O,E>,cont:Terminal<Chunk<Oi,E>,Nada>) -> {
            final res = fn(p);
            __.log().trace('$res');
            return cont.receive(res.forward(Nada));
          }
        )
      )
    );
  }
  static public function convert<O,Oi,E>(self:ProduceDef<O,E>,then:Convert<O,Oi>):Produce<Oi,E>{
    return lift(Fletcher.Then(self,(Convert._.toModulate(then).toFletcher())));
  }
  static public function recover<O,E>(self:ProduceDef<O,E>,rec:Recover<O,E>):Provide<O>{
    return Provide.lift(self.then(rec.toReform()));
  }
  static public function attempt<O,Oi,E>(self:ProduceDef<O,E>,that:Attempt<O,Oi,E>):Produce<Oi,E>{
    return lift(self.then(that.toModulate()));
  }
  static public function deliver<O,E>(self:ProduceDef<O,E>,fn:O->Void):Execute<E>{
    return Execute.lift(self.then(
      Fletcher.Sync(
        (res:Upshot<O,E>) -> res.fold(
          (s) -> {
            fn(s);
            return Report.unit();
          },
          (e) -> Report.pure(e)
        )
      )
    ));
  }
  static public function reclaim<O,Oi,E>(self:ProduceDef<O,E>,next:Convert<O,Produce<Oi,E>>):Produce<Oi,E>{
    return lift(
      self.then(
        next.toModulate().toFletcher()
      )).attempt(
        Attempt.lift(Fletcher.Anon(
          (prd:Produce<Oi,E>,cont:Terminal<Upshot<Oi,E>,Nada>) -> cont.receive(prd.forward(Nada))
        ))
      );
  }
  static public function arrange<S,O,Oi,E>(self:ProduceDef<O,E>,next:Arrange<O,S,Oi,E>):Attempt<S,Oi,E>{
    return Attempt.lift(Fletcher.Anon(
      (i:S,cont:Terminal<Upshot<Oi,E>,Nada>) -> cont.receive(self.forward(Nada).flat_fold(
        res -> next.forward(res.map(__.couple.bind(_,i))),
        err -> cont.error(err)
      ))
    ));
  }
  static public function rearrange<S,O,Oi,E>(self:ProduceDef<O,E>,next:Arrange<Upshot<O,E>,S,Oi,E>):Attempt<S,Oi,E>{
    return Attempt.lift(
      Fletcher.Anon(
        (i:S,cont:Terminal<Upshot<Oi,E>,Nada>) -> 
          cont.receive(self.forward(Nada).flat_fold(
            res -> next.forward(__.accept(__.couple(res,i))),
            no  -> cont.error(no)
          ))
      ) 
    );
  }
  static public function modulate<O,Oi,E>(self:ProduceDef<O,E>,that:Modulate<O,Oi,E>):Produce<Oi,E>{
    return lift(self.then(that));
  }
  static public inline function fudge<O,E>(self:ProduceDef<O,E>):O{
    return Fletcher._.fudge(self,Nada).fudge();
  }
  static public inline function force<O,E>(self:ProduceDef<O,E>):Upshot<O,E>{
    return Fletcher._.force(self,Nada).fudge();
  }
  static public function flat_map<O,Oi,E>(self:ProduceDef<O,E>,that:O->Produce<Oi,E>):Produce<Oi,E>{
    return lift(
      Fletcher.FlatMap(
        self,
        (res:Upshot<O,E>) -> res.fold(
          (o) -> that(o),
          (e) -> Produce.fromUpshot(__.reject(e))
        )
      )
    );
  }
  static public function fold_flat_map<O,Oi,E>(self:ProduceDef<O,E>,that:Upshot<O,E>->Produce<Oi,E>):Produce<Oi,E>{
    return lift(
      Fletcher.FlatMap(
        self,
        (res:Upshot<O,E>) -> that(res).prj()
      )
    );
  }
  static public function then<O,Oi,E>(self:ProduceDef<O,E>,that:Fletcher<Upshot<O,E>,Oi,Nada>):Provide<Oi>{
    return Provide.lift(Fletcher.Then(self,that));
  }
  static public function split<O,Oi,E>(self:ProduceDef<O,E>,that:Produce<Oi,E>):Produce<Couple<O,Oi>,E>{
    return lift(Fletcher._.split(self,that).then(
      Fletcher.fromFun1R(
        __.decouple((l:Upshot<O,E>,r:Upshot<Oi,E>) -> l.zip(r))
      )
    ));
  }
  static public function adjust<O,Oi,E>(self:ProduceDef<O,E>,fn:O->Upshot<Oi,E>):Produce<Oi,E>{
    return lift(Fletcher._.then(
      self,
      Fletcher.fromFun1R((res:Upshot<O,E>) -> res.flat_map(fn))
    ));
  }
  static public function pledge<O,E>(self:ProduceDef<O,E>):Pledge<O,E>{
    return Pledge.lift(
      (Fletcher._.future(self,Nada)).map(
        (outcome:Outcome<Upshot<O,E>,Defect<Nada>>) -> (outcome.fold(
          (x:Upshot<O,E>)       -> x,
          (e:Defect<Nada>)      -> __.reject(e.elide().toRefuse())
        ))
      )
    );
  }
  static public function toModulate<P,R,E>(self:ProduceDef<R,E>):Modulate<P,R,E>{
    return Modulate.lift(
      Fletcher.Anon(
        (p:Upshot<P,E>,cont:Waypoint<R,E>) -> cont.receive(self.forward(Nada))
      )
    );
  }
  static public function zip<Ri,Rii,E>(self:Produce<Ri,E>,that:Produce<Rii,E>):Produce<Couple<Ri,Rii>,E>{
    return lift(
      Fletcher._.pinch(self,that).map(
        __.decouple(
          (lhs:Upshot<Ri,E>,rhs:Upshot<Rii,E>) -> lhs.zip(rhs)
        )
      ) 
    );
  }
  static public function command<O,E>(self:ProduceDef<O,E>,that:Command<O,E>):Produce<O,E>{
    return Produce.lift(
      Fletcher.Then(
        self,
        Fletcher.Anon(
          (res:Upshot<O,E>,cont:Terminal<Upshot<O,E>,Nada>) -> res.fold(
            ok -> cont.receive(that.produce(Produce.pure(ok)).forward(ok)),
            no -> cont.receive(cont.value(__.reject(_ -> no)))
          )
        )
      )
    );
  }
  // static public function pledge<O,E>(self:ProduceDef<O,E>):Pledge<O,E>{
  //   final trigger = Future.trigger();
  //   return Pledge.lift(self.deliver(
  //     (v) -> {
  //       trigger.trigger(__.accept(v));
  //     }
  //   ).deliver(
  //     e -> trigger.trigger(__.reject(f -> e))
  //   ).reply().flatMap(
  //     (_) -> trigger.asFuture()
  //   ));
  // }
}