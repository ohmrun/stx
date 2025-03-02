package stx.coroutine.pack;

typedef TunnelDef<I,O,E> = CoroutineSum<I,O,Nada,E>;

@:using(stx.coroutine.pack.Tunnel.TunnelLift)
@:forward abstract Tunnel<I,O,E>(TunnelDef<I,O,E>) from TunnelDef<I,O,E> to TunnelDef<I,O,E>{
  

  public function new(self) this = self;
  @:noUsing static public function lift<I,O,E>(self:TunnelDef<I,O,E>) return new Tunnel(self);

  @:noUsing static public function fromFun2CallbackVoid<I,O,E>(arw:I->(O->Void)->Void):Tunnel<I,O,E>{
    return lift(__.wait(
      Transmission.fromFun1R(
        function rec(i:I){ 
          var future : FutureTrigger<Coroutine<I,O,Nada,E>> = Future.trigger();
          arw(i,
            (o) -> {
              future.trigger(__.emit(o,__.wait(Transmission.fromFun1R(rec))));
            }
          );
          return __.hold(Held.Guard(future));
        }
      )
    ));
  }
  @:noUsing static public function fromEmiterConstrucor<I,O,E>(cons:I->Emiter<O,E>):Tunnel<I,O,E>{
    return __.wait(
      Transmission.fromFun1R(
        (i:I) -> {
          function recurse(emiter:Emiter<O,E>):Coroutine<I,O,Nada,E>{
            return switch(emiter){
              case Wait(fn) : __.wait(
                Transmission.fromFun1R(cons.fn().then(recurse))
              );
              case Emit(head,tail)  : __.emit(head,recurse(tail));
              case Halt(r)          : __.halt(r);

              case Hold(h)          : __.hold(
                Held.lift(h.map(
                  (pipe) -> Coroutine.lift(recurse(pipe))
                ))
              );
            }
          }
          return recurse(cons(i));
        }
      )
    );
  }
  static public function fromFunction<I,O,E>(fn:I->O):Tunnel<I,O,E>{
    return __.wait(
      Transmission.fromFun1R(
        function rec(i:I){ return __.emit(fn(i),__.wait(Transmission.fromFun1R(rec))); }
      )
    );
  }
  @:to public function toCoroutine():Coroutine<I,O,Nada,E>{
    return this;
  }
  public function toCoroutineStop<R>():Coroutine<I,O,R,E>{
    return this.flat_map_r(
      (r:Nada) -> __.stop()
    );
  }
  @:from static public function fromCoroutine<I,O,E>(self:Coroutine<I,O,Nada,E>):Tunnel<I,O,E>{
    return lift(self);
  }
  public function prj(){
    return this;
  }
}
class TunnelLift{
  @:noUsing static private function lift<I,O,E>(self:TunnelDef<I,O,E>) return Tunnel.lift(self);
  static public function append<I,O,E>(prc0:Tunnel<I,O,E>,prc1:Thunk<Tunnel<I,O,E>>):Tunnel<I,O,E>{
    return switch (prc0){
      case Emit(head,tail)              : Emit(head,append(tail,prc1));
      case Wait(arw)                    : Wait(arw.mod(__.into(append.bind(_,prc1))));
      case Halt(Production(Nada))      : prc1();
      case Halt(Terminated(Stop))       : prc1();
      case Halt(Terminated(cause))      : Halt(Terminated(cause));
      case Halt(e)                      : Halt(e);
      case Hold(ft)                     : Hold(ft.mod(__.into(append.bind(_,prc1))));
    }
  }
  static public function flat_map<I,O,O2,R,E>(prc:Tunnel<I,O,E>,fn:O->Tunnel<I,O2,E>):Tunnel<I,O2,E>{
    return lift(switch (prc){
      case Emit(head,tail)  : append(fn(head),flat_map.bind(tail,fn));
      case Wait(arw)        : Wait(
        function(i){
          var next = arw(i);
          return flat_map(next,fn);
        }
      );
      case Halt(e)          : Halt(e);
      case Hold(ft)         : Hold(ft.mod(__.into(flat_map.bind(_,fn))));
    });
  }
  static public function emiter<I,O,E>(self:Tunnel<I,O,E>,that:Emiter<I,E>):Emiter<O,E>{
    __.log().debug('emiter: $self');
    var f = emiter.bind(_,that);
    return Emiter.lift(switch(self){
      case Emit(head,tail)      : __.emit(head,f(tail));
      case Hold(ft)             : __.hold(
        Held.lift(ft.map(
          (pipe) -> Coroutine.lift(emiter(pipe,that))
        ))
      );
      case Halt(e)              : __.halt(e);
      case Wait(fn)             : 
        switch(that){
          case Emit(head,tail)  : emiter(fn(head),tail); 
          case Hold(ft)         : __.hold(Held.lift(ft.map(
            (pipe) -> Coroutine.lift(emiter(self,pipe))
          )));
          case Wait(arw)        : emiter(self,arw(Push(Nada)));
          case Halt(done)       : __.halt(done);
        }
    });
  }
  static public function demand<I,O,E>(self:TunnelDef<I,O,E>,req:I,fn:Upshot<O,E> -> Bool):Tunnel<I,O,E>{
    final source  = Pledge.trigger();
    var sent      = false;
    var done      = false;
    function f(self:TunnelDef<I,O,E>):TunnelDef<I,O,E>{
      return switch(self){
        case Emit(o,next)               : 
          if(sent){
            if(!done){
              fn(__.accept(o)).if_else(
                ()  -> {
                  done = true;
                  return next;
                },
                () -> f(next)
              );
            }else{
              next;
            }
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
            final err =__.fault().digest((_:Digests) -> _.e_undefined());
            fn(__.reject(err));
            __.term(err);
          }else{
            __.prod(Nada);
          } 
        case Halt(Terminated(Stop))     : __.stop();
        case Halt(Terminated(Exit(e)))  : __.exit(e);
      }
    }
    return Tunnel.lift(f(self));
  }
  static public function mod<I,O,R,E>(self:TunnelDef<I,O,E>,fn:TunnelDef<I,O,E>->Tunnel<I,O,E>):Tunnel<I,O,E>{
    final f : TunnelDef<I,O,E> -> TunnelDef<I,O,E> = mod.bind(_,fn.fn().then(x -> x.prj()));
    return lift(switch(self){
      case Hold(held)                     : __.hold(held.mod(f));
      case Wait(fn)                       : __.wait(fn.mod(f));
      case Halt(h)                        : __.halt(h);
      case Emit(data,next)                : __.emit(data,f(next));
    });
  }
  static public function seq<I,O,R,Ri,E>(self:CoroutineSum<I,O,R,E>,that:CoroutineSum<I,O,R,E>):Coroutine<I,O,R,E>{
    trace('$self $that');
    return switch([self,that]){
      case [Wait(l),Wait(r)]                    : 
        __.tran(
          (x) -> {
            return seq(l.imply(x),r.imply(x));
          }
        );
      case [Emit(eI,restI),Emit(eII,restII)]      :
        __.emit(eI,Emit(eII,seq(restI,restII)));
      case [Halt(Production(x)),next]             : 
        next;
      case [self,Halt(Production(x))]             : 
        self;
      case [Halt(Terminated(Stop)),next]          : 
        next;
      case [self,Halt(Terminated(Stop))]          : 
        self;
      case [Halt(Terminated(cause)),_]            : 
        __.term(cause);
      case [_,Halt(Terminated(cause))]            : 
        __.term(cause);
      case [Wait(fn),that]                        :
        __.tran(x -> seq(fn.imply(x),that));
      case [Emit(x,n),that]                       :
        __.emit(x,seq(n,that));
      case [Hold(l),Hold(r)]                      :
        __.hold(
          Held.Pause(
            () -> return self.squeeze().mod(
              x -> seq(x,that.squeeze())
            )
          )
        );
      case [Hold(l),x] : 
          __.hold(
            l.mod(v -> seq(x,v))
          );
      case [x,Hold(l)] : 
        __.hold(
          l.mod(v -> seq(x,v))
        );
    }
  }
  static public function amb<I,O,R,Ri,E>(self:CoroutineSum<I,O,R,E>,that:CoroutineSum<I,O,R,E>):Coroutine<I,O,R,E>{
    trace('$self $that');
    var l_res = __.option();
    var r_res = __.option();

    final yes   = stx.nano.Math.rndOne() == 1;
    final main  = yes ? that : self;
    final next  = yes ? self : that;

    return switch([main,next]){
      case [Wait(l),Wait(r)]                    : 
        __.tran(
          (x) -> {
            return amb(l.imply(x),r.imply(x));
          }
        );
      case [Emit(eI,restI),Emit(eII,restII)]      :
        __.emit(eI,Emit(eII,amb(restI,restII)));
      case [Halt(Production(x)),next]             : 
        next;
      case [main,Halt(Production(x))]             : 
        main;
      case [Halt(Terminated(Stop)),next]          : 
        next;
      case [main,Halt(Terminated(Stop))]          : 
        main;
      case [Halt(Terminated(cause)),_]            : 
        __.term(cause);
      case [_,Halt(Terminated(cause))]            : 
        __.term(cause);
      case [Wait(fn),next]                        :
        __.tran(x -> amb(fn.imply(x),next));
      case [Emit(x,n),next]                       :
        __.emit(x,amb(n,next));
      case [Hold(l),Hold(r)]                      :
        __.hold(
          Held.Pause(
            () -> return main.squeeze().mod(
              x -> amb(x,next.squeeze())
            )
          )
        );
      case [Hold(l),x] : 
          __.hold(
            l.mod(v -> amb(x,v))
          );
      case [x,Hold(l)] : 
        __.hold(
          l.mod(v -> amb(x,v))
        );
    }
  }
  /**
   Reorders the outputs such that the first `true` from `fn` is produced first. `Error` if the stream
   terminates without ever returning `true`. Infinite `Tunnel` unaffected.
  **/
  // static public function require<I,O,Z,E>(self:TunnelDef<I,O,E>,fn:Arrange<O,Tunnel<I,O,E>>->Option<Tunnel<I,O,E>>):Tunnel<I,O,E>{
  //   function rec(self:TunnelDef<I,O,E>):TunnelDef<I,O,E>{
      
  //   }
  //}
  //static public function tap<I,O,E>(self:Tu)
}
