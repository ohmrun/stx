package eu.ohmrun;

import tink.core.Future;

using stx.Pico;
using stx.Nano;
using stx.Fail;
using stx.Log;
using stx.Assert;
using eu.ohmrun.fletcher.Core;
using eu.ohmrun.Fletcher;
using eu.ohmrun.fletcher.Logging;

typedef ArwOutDef<R,E>    = Outcome<R,Error<E>>;
typedef ArwOut<R,E>       = ArwOutDef<R,E>; 

interface FletcherApi<P,Pi,E> extends StxMemberApi{
  final source : Position;
  public function defer(p:P,cont:Terminal<Pi,E>):Work;
  public function toFletcher():Fletcher<P,Pi,E>;
}
abstract class FletcherCls<P,R,E> implements FletcherApi<P,R,E> extends StxMemberCls{
  public final source : Position;
  public function new(?pos:Pos){
    super();
    this.source = pos;
  }
  public function get_stx_tag(){
    return 1;
  }
  abstract public function defer(p:P,cont:Terminal<R,E>):Work;
  public function toString(){
    return Type.getClassName(Type.getClass(this)) + ":" + source;
  }
  public function toFletcher():Fletcher<P,R,E>{
    return this;
  }
}
typedef FletcherFun<P,Pi,E> = P -> Terminal<Pi,E> -> Work;
typedef FletcherDef<P,Pi,E> = FletcherApi<P,Pi,E>;

@:using(eu.ohmrun.Fletcher.FletcherLift)
@:forward abstract Fletcher<P,Pi,E>(FletcherDef<P,Pi,E>) from FletcherDef<P,Pi,E> to FletcherDef<P,Pi,E>{
  static public function ctx<P,R,E>(wildcard:Wildcard,environment:P,?ok,?no):eu.ohmrun.fletcher.core.Context<P,R,E>{
    return eu.ohmrun.fletcher.core.Context.make(environment,ok,no);
  }
  public function new(self) this = self;
  static public function lift<P,Pi,E>(self:FletcherDef<P,Pi,E>):Fletcher<P,Pi,E> return new Fletcher(self);

  public function prj():FletcherDef<P,Pi,E> return this;
  private var self(get,never):Fletcher<P,Pi,E>;
  private function get_self():Fletcher<P,Pi,E> return lift(this);

  @:from static public function fromApi<P,Pi,E>(self:FletcherApi<P,Pi,E>){
    return lift(self); 
  }
  @:noUsing static public function unit<P,E>():Fletcher<P,P,E>{
    return Sync(x -> x);
  }
  @:noUsing static public function constant<P,R,E>(self:ArwOut<R,E>):Fletcher<P,R,E>{
    return Fletcher.Anon(
      (_:P,cont:Terminal<R,E>) -> cont.receive(cont.issue(self))
    );
  }
  @:noUsing static public function pure<P,R,E>(self:R):Fletcher<P,R,E>{
    return constant(__.success(self));
  }
  @:noUsing static public inline function fromFun1R<P,R,E>(self:P->R):Fletcher<P,R,E>{
    return Sync(self);
  }
  @:noUsing static public inline function fromFunXR<R,E>(self:Void->R):Fletcher<Nada,R,E>{
    return Sync((_:Nada) -> self());
  }
  //?pos:haxe.PosInfos
  static public function forward<P,Pi,E>(self:FletcherApi<P,Pi,E>,p:P,?pos:Pos):Receiver<Pi,E>{
    #if debug
      //__.log().debug(_ -> _.pure(pos));
      __.assert().that().exists(self);
      //__.assert().that().exists(p);
    #end
    return Receiver.lift(
      Cont.Anon(
        function(k:ReceiverSinkApi<Pi,E>){
          #if debug
          __.log().trace('forward called $p');
          #end
          var ft : FutureTrigger<ArwOut<Pi,E>> = Future.trigger();
          var fst = self.defer(
            p,
            Terminal.lift(
              Cont.AnonAnon((t_sink:TerminalSink<Pi,E>) -> {
                #if debug
                  __.log().trace('FORWARD forwarding');
                  __.assert().that().exists(t_sink);
                #end
                final result =  t_sink(ft);
                //$type(result);
                #if debug
                __.log().trace('FORWARD after t_sink: $result');
                #end
                return result;
              },pos)
            )
          );
          __.log().trace('FORWARD before apply');
          var snd = k.apply(ft.asFuture());
          __.log().trace('FORWARD after apply');
          return fst.seq(snd);
        }
      )
    );
  }
  @:noUsing static public inline function Sync<P,R,E>(fn:P->R):Fletcher<P,R,E>{
    return new eu.ohmrun.fletcher.term.AnonSync(fn);
  }
  @:noUsing static public function FlatMap<P,R,Ri,E>(self:Fletcher<P,R,E>,fn:R->Fletcher<P,Ri,E>):Fletcher<P,Ri,E>{
    return Fletcher.Anon(
      (p:P,cont:Terminal<Ri,E>) -> cont.receive(self.forward(p).flat_fold(
        (ok:R)  -> fn(ok).forward(p),
        no      -> Receiver.error(no)
      ))
    );
  }
  @:noUsing static public function Anon<P,R,E>(self:FletcherFun<P,R,E>,?pos:Pos):Fletcher<P,R,E>{
    return new eu.ohmrun.fletcher.term.Anon(self,pos);
  }
  @:noUsing static public inline function Then<P,Ri,Rii,E>(self:Fletcher<P,Ri,E>,that:Fletcher<Ri,Rii,E>,?pos:Pos):Fletcher<P,Rii,E>{
    return new eu.ohmrun.fletcher.term.Then(self,that,pos);
  }
  @:noUsing static public inline function Delay<I,E>(ms):Fletcher<I,I,E>{
    return Fletcher.Anon(
      (ipt:I,cont:Terminal<I,E>) -> {
        var bang = new stx.stream.Timeout(ms).prj().map(_ -> __.success(ipt));
        return cont.receive(cont.later(bang));
      }
    );
  }
}
class FletcherLift{
  static public function lift<P,R,E>(self:FletcherDef<P,R,E>):Fletcher<P,R,E>{
    return Fletcher.lift(self);
  }
  static public function environment<P,Pi,E>(self:Fletcher<P,Pi,E>,p:P,success:Pi->Void,?failure:Error<E>->Void,?pos:Pos):Fiber{
    final context     = __.ctx(p,success,failure);
    final process     = self;
    final completion  = new eu.ohmrun.fletcher.Completion(context,process);
    return Fiber.lift(completion);
  }
  static public function fudge<P,R,E>(self:Fletcher<P,R,E>,p:P):R{
    var val = null;
    environment(
      self,
      p,
      (ok) -> {
        __.log().debug('fudged');
        val = ok;
      },
      (no) -> {
        __.log().debug('fudged:fail');
        __.crack(no);
      }
    ).crunch();
    __.assert().that().exists(val);
    
    return val;
  }
  static public function force<P,R,E>(self:Fletcher<P,R,E>,p:P):Upshot<R,E>{
    var val = null;
    environment(
      self,
      p,
      (ok) -> {
        __.log().debug('fudged');
        val = __.accept(ok);
      },
      (no) -> {
        __.log().debug('fudged:fail');
        val = __.reject(no);
      }
    ).crunch();
    __.assert().that().exists(val);
    
    return val;
  }
  static public function then<Pi,Ri,Rii,E>(self:Fletcher<Pi,Ri,E>,that:Fletcher<Ri,Rii,E>):Fletcher<Pi,Rii,E>{
    //__.log().debug(_ -> _.pure(pos));
    return Fletcher.Then(self,that);
  }
  static public function pair<Pi,Ri,Pii,Rii,E>(self:FletcherDef<Pi,Ri,E>,that:Fletcher<Pii,Rii,E>):Fletcher<Couple<Pi,Pii>,Couple<Ri,Rii>,E>{
    return Fletcher.Anon((p:Couple<Pi,Pii>,cont:Terminal<Couple<Ri,Rii>,E>) -> {
      final lhs = self.forward(p.fst());
      final rhs = that.forward(p.snd());
      return cont.receive(lhs.zip(rhs));
    });
  }
  static public function split<Pi,Ri,Rii,E>(self:FletcherDef<Pi,Ri,E>,that:FletcherDef<Pi,Rii,E>):Fletcher<Pi,Couple<Ri,Rii>,E>{
    return Fletcher.Anon(
      (pi:Pi,cont) -> pair(self,that).defer(__.couple(pi,pi),cont)
    );
  }
  static public function first<Pi,Pii,Ri,E>(self:FletcherDef<Pi,Ri,E>):Fletcher<Couple<Pi,Pii>,Couple<Ri,Pii>,E>{
    return pair(self,Fletcher.unit()); 
  }
  static public function pinch<P,Ri,Rii,E>(self:FletcherDef<P,Ri,E>,that:Fletcher<P,Rii,E>):Fletcher<P,Couple<Ri,Rii>,E>{
    return Fletcher.Anon((p:P,cont:Terminal<Couple<Ri,Rii>,E>) -> cont.receive(
      self.forward(p).zip(that.forward(p))
    ));
  }
  static public function map<P,Ri,Rii,E>(self:FletcherDef<P,Ri,E>,that:Ri->Rii,?pos:Pos):Fletcher<P,Rii,E>{
    return Fletcher.Then(
      self,
      Fletcher.Sync(that),
      pos
    );
  }
  static public function mapi<P,Pi,R,E>(self:FletcherDef<Pi,R,E>,that:P->Pi):Fletcher<P,R,E>{
    return Fletcher.Anon(
      (p:P,cont:Terminal<R,E>) -> self.defer(that(p),cont)
    );
  }
  static public function joint<I,Oi,Oii,E>(lhs:FletcherDef<I,Oi,E>,rhs:Fletcher<Oi,Oii,E>):Fletcher<I,Couple<Oi,Oii>,E>{
    return then(lhs,Fletcher.unit().split(rhs));
  }
  static public function bound<P,Oi,Oii,E>(self:FletcherDef<P,Oi,E>,that:Fletcher<Couple<P,Oi>,Oii,E>):Fletcher<P,Oii,E>{
    return joint(Fletcher.unit(),self).then(that);
  }
  static public function broach<Oi,Oii,E>(self:FletcherDef<Oi,Oii,E>):Fletcher<Oi,Couple<Oi,Oii>,E>{
    return bound(self,Fletcher.Sync(__.decouple(__.couple)));
  }
  static public function future<P,O,E>(self:FletcherDef<P,O,E>,p:P):Future<Outcome<O,Error<E>>>{
    return Future.irreversible(
      cb -> environment(
        self,
        p,
        (ok) -> cb(__.success(ok)),
        (no) -> cb(__.failure(no))
      ).submit() 
    );
  }
  static public function produce<P,R,E>(self:Fletcher<P,R,E>,i:P):Produce<R,E>{
    return Produce.lift(
      Fletcher.Anon(
        (_:Nada,cont:Terminal<Upshot<R,E>,Nada>) -> {
          return cont.receive(
            self.forward(i).fold_mapp(
              (ok:R)          -> __.success(__.accept(ok)),
              (no:Error<E>)  -> __.success(__.reject(no))
            )
          );
        }
      )
   );
  } 	
}
typedef Fiber                   = eu.ohmrun.fletcher.Fiber;
typedef FiberDef                = eu.ohmrun.fletcher.Fiber.FiberDef;

typedef Convert<I,O>            = eu.ohmrun.fletcher.Convert<I,O>;
typedef ConvertDef<I,O>         = eu.ohmrun.fletcher.Convert.ConvertDef<I,O>;
typedef ConvertArg<P,R>         = eu.ohmrun.fletcher.Convert.ConvertArg<P,R>;

typedef Provide<O>              = eu.ohmrun.fletcher.Provide<O>;
typedef ProvideDef<O>           = eu.ohmrun.fletcher.Provide.ProvideDef<O>;

typedef ModulateApi<P,R,E>      = eu.ohmrun.fletcher.Modulate.ModulateApi<P,R,E>;
typedef ModulateDef<P,R,E>      = eu.ohmrun.fletcher.Modulate.ModulateDef<P,R,E>;
typedef Modulate<P,R,E>         = eu.ohmrun.fletcher.Modulate<P,R,E>;
typedef ModulateArgSum<P,R,E>   = eu.ohmrun.fletcher.Modulate.ModulateArgSum<P,R,E>;
typedef ModulateArg<P,R,E>      = eu.ohmrun.fletcher.Modulate.ModulateArg<P,R,E>;

typedef ArrangeDef<I,S,O,E>     = eu.ohmrun.fletcher.Arrange.ArrangeDef<I,S,O,E>;
typedef Arrange<I,S,O,E>        = eu.ohmrun.fletcher.Arrange<I,S,O,E>;
typedef ArrangeArgSum<I,S,O,E>  = eu.ohmrun.fletcher.Arrange.ArrangeArgSum<I,S,O,E>;
typedef ArrangeArg<I,S,O,E>     = eu.ohmrun.fletcher.Arrange.ArrangeArg<I,S,O,E>;

typedef ReframeDef<P,R,E>       = eu.ohmrun.fletcher.Reframe.ReframeDef<P,R,E>;
typedef Reframe<P,R,E>          = eu.ohmrun.fletcher.Reframe<P,R,E>;

typedef AttemptDef<P,R,E>       = eu.ohmrun.fletcher.Attempt.AttemptDef<P,R,E>;
typedef Attempt<P,R,E>          = eu.ohmrun.fletcher.Attempt<P,R,E>;
typedef AttemptArgSum<P,R,E>    = eu.ohmrun.fletcher.Attempt.AttemptArgSum<P,R,E>;
typedef AttemptArg<P,R,E>       = eu.ohmrun.fletcher.Attempt.AttemptArg<P,R,E>;

typedef CommandDef<I,E>         = eu.ohmrun.fletcher.Command.CommandDef<I,E>;
typedef Command<I,E>            = eu.ohmrun.fletcher.Command<I,E>;
typedef CommandArgSum<I,E>      = eu.ohmrun.fletcher.Command.CommandArgSum<I,E>;
typedef CommandArg<I,E>         = eu.ohmrun.fletcher.Command.CommandArg<I,E>;

typedef DiffuseDef<P,R,E>       = eu.ohmrun.fletcher.Diffuse.DiffuseDef<P,R,E>;
typedef Diffuse<P,R,E>          = eu.ohmrun.fletcher.Diffuse<P,R,E>;

typedef ExecuteDef<E>           = eu.ohmrun.fletcher.Execute.ExecuteDef<E>;
typedef Execute<E>              = eu.ohmrun.fletcher.Execute<E>;

typedef PerformDef              = eu.ohmrun.fletcher.Perform.PerformDef;
typedef Perform                 = eu.ohmrun.fletcher.Perform;

typedef ProduceDef<O,E>         = eu.ohmrun.fletcher.Produce.ProduceDef<O,E>;
typedef Produce<O,E>            = eu.ohmrun.fletcher.Produce<O,E>;
typedef ProduceArgSum<O,E>      = eu.ohmrun.fletcher.Produce.ProduceArgSum<O,E>;
typedef ProduceArg<O,E>         = eu.ohmrun.fletcher.Produce.ProduceArg<O,E>;

typedef ProposeDef<O,E>         = eu.ohmrun.fletcher.Propose.ProposeDef<O,E>;
typedef Propose<O,E>            = eu.ohmrun.fletcher.Propose<O,E>;

typedef RecoverDef<I,E>         = eu.ohmrun.fletcher.Recover.RecoverDef<I,E>;
typedef Recover<I,E>            = eu.ohmrun.fletcher.Recover<I,E>;

typedef ReformDef<P,R,E>        = eu.ohmrun.fletcher.Reform.ReformDef<P,R,E>;
typedef Reform<P,R,E>           = eu.ohmrun.fletcher.Reform<P,R,E>;

typedef ResolveDef<I,E>         = eu.ohmrun.fletcher.Resolve.ResolveDef<I,E>;
typedef Resolve<I,E>            = eu.ohmrun.fletcher.Resolve<I,E>;

typedef RegulateDef<R,E>        = eu.ohmrun.fletcher.Regulate.RegulateDef<R,E>;
typedef Regulate<R,E>           = eu.ohmrun.fletcher.Regulate<R,E>;

typedef ScenarioDef<P,Ri,Rii,E>      = eu.ohmrun.fletcher.Scenario.ScenarioDef<P,Ri,Rii,E>;
typedef Scenario<P,Ri,Rii,E>         = eu.ohmrun.fletcher.Scenario<P,Ri,Rii,E>;
typedef ScenarioArgSum<P,Ri,Rii,E>   = eu.ohmrun.fletcher.Scenario.ScenarioArgSum<P,Ri,Rii,E>;
typedef ScenarioArg<P,Ri,Rii,E>      = eu.ohmrun.fletcher.Scenario.ScenarioArg<P,Ri,Rii,E>;

typedef VentureDef<P,R,E>             = eu.ohmrun.fletcher.Venture.VentureDef<P,R,E>;
typedef Venture<P,R,E>                = eu.ohmrun.fletcher.Venture<P,R,E>;

typedef Progress<R,E>                 = eu.ohmrun.fletcher.Progress<R,E>;

class FletcherWildcards{
  // static public function arw<P,R,E>(wildcard:Wildcard,fn:F<P,R>):Fletcher<P,R,E>{
  //   return Fletcher.Sync(fn.toUnary().prj());
  // }
  static public inline function attempt<P,R,E>(wildcard:Wildcard,self:AttemptArg<P,R,E>,?pos:Pos):Attempt<P,R,E>{
    //__.log().debug(_ -> _.pure(pos));
    return Attempt.bump(self);
  }
  static public inline function produce<R,E>(wildcard:Wildcard,self:ProduceArg<R,E>):Produce<R,E>{
    return Produce.bump(self);
  }
  static public inline function arrange<P,S,R,E>(wildcard:Wildcard,self:ArrangeArg<P,S,R,E>):Arrange<P,S,R,E>{
    return Arrange.bump(self);
  }
  static public inline function modulate<P,R,E>(wildcard:Wildcard,self:ModulateArg<P,R,E>):Modulate<P,R,E>{
    return Modulate.bump(self);
  }
  static public inline function command<P,E>(wildcard:Wildcard,self:CommandArg<P,E>):Command<P,E>{
    return Command.bump(self);
  }
  static public inline function recover<P,E>(wildcard:Wildcard,self:RecoverDef<P,E>){
    return Recover.lift(self);
  }
  static public inline function convert<P,R>(wildcard:Wildcard,self:ConvertArg<P,R>){
    return Convert.lift(self);
  }
  // static public inline function sequent<P,R,E>(wildcard:Wildcard,self:SequentArg<P,R,E>):Sequent<P,R,E>{
  //   return Sequent.bump(self);
  // }
}
// class LiftFletcherLoad{
//   static public function load<P,R,E>(self:Context<P,R,E>,arrowlet:Fletcher<P,R,E>):Fiber{
//     return Fiber.lift(new Completion(self,arrowlet));
//   }
// }
class LiftProvideLoad{
  static public function load<P,R,E>(self:Context<Nada,R,Nada>,arrowlet:Provide<R>):Fiber{
    return Fiber.lift(new eu.ohmrun.fletcher.Completion(self,arrowlet.toFletcher()));
  }
  // static public function fly<R,E>(wildcard:Wildcard,arrowlet:Provide<R>,?on_value:R->Void,?on_error:Error<Nada>->Void):Fiber{
  //   return Fiber.lift(new eu.ohmrun.fletcher.Completion(Context.make(Nada,on_value,on_error),arrowlet));
  // }
}