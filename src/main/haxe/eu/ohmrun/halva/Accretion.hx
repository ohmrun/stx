package eu.ohmrun.halva;

import eu.ohmrun.halva.Core;

interface AccretionApi<T>{
  public final satisfies          : SatisfiesApi<T>;

  private final _signal           : SignalTrigger<Couple<Register,LVar<T>>>;
  private final signal            : Signal<Couple<Register,LVar<T>>>;

  public function create():Register;
  public function update(r:Register,data:LVar<T>):Bool;
  public function redeem(r:Register,threshold:ThresholdSet<T>):Future<Option<LVar<T>>>;
  public function listen(r:Register,threshold:ThresholdSet<T>):Signal<LVar<T>>;
  
  public function toAccretion():Accretion<T>;
}
class AccretionCls<T> implements AccretionApi<T>{

  public final satisfies          : SatisfiesApi<T>;
  var data                        : RedBlackMap<Register,LVar<T>>;

  private final _signal           : SignalTrigger<Couple<Register,LVar<T>>>;
  private final signal            : Signal<Couple<Register,LVar<T>>>;

  public function new(satisfies,data){
    this.satisfies        = satisfies;
    this.data             = data;
    this._signal          = Signal.trigger();
    this.signal           = _signal.asSignal();
  }
  public function toAccretion(){
    return Accretion.lift(this);
  }
  public function create():Register{
    final reg = new Register();
    this.data = this.data.set(reg,LVar.unit());
    return reg;
  }
  public function update(r:Register,data:LVar<T>):Bool{
    final last        = this.data.get(r).defv(LVar.unit());
    __.log().trace('update on $last');
    final next        = this.satisfies.lub().plus(last,data);
    //__.log().debug(_ -> _.thunk(() -> '$next'));
    var updated       = false;
    final comparable  = this.satisfies.toComparable();
    if(next != TOP){
      __.log().trace('comparing $last and $next');
      if(comparable.eq().comply(last,next).is_equal() || comparable.lt().comply(last,next).is_less_than()){
        this.data   = this.data.set(r,next);
        __.log().trace('data now ${this.data}');
        _signal.trigger(__.couple(r,next));
        updated = true;
      }
    }
    __.log().trace('updated? $updated to $next');
    return updated;
  }
  public function redeem(r:Register,threshold:ThresholdSet<T>):Future<Option<LVar<T>>>{
    final next : Option<LVar<T>> = this.data.get(r).map(Some).defv(None);
    __.log().trace('$next');
    final ok   = next.map(
      x -> filter(x,threshold)
    ).defv(false);
    __.log().trace('$ok');
    return ok.if_else(
      () -> Future.irreversible((cb) -> cb(next)),
      () -> listen(r,threshold).nextTime(_ -> true).map(Some)
    );
  }
  public function listen(r:Register,threshold:ThresholdSet<T>):Signal<LVar<T>>{
    return signal.filter(
      __.decouple(
        (x,y) -> (x == r) && filter(y,threshold)
      )
    ).map(__.decouple((_,y) -> y));
  }
  static private function filter<T>(item:LVar<T>,threshold:ThresholdSet<T>){
    return threshold.toIter().lfold(
      (next:LVar<T>,m:Bool) -> m.if_else(
        () -> threshold.with.lt().comply(item,next).is_not_less_than() || threshold.with.eq().comply(item,next).is_equal(),
        () -> false
      ),
      true
    );
  }
}
@:using(eu.ohmrun.halva.Accretion.AccretionLift)
@:forward abstract Accretion<T>(AccretionApi<T>) from AccretionApi<T> to AccretionApi<T>{
  static public var _(default,never) = AccretionLift;
  public inline function new(self:AccretionApi<T>) this = self;
  @:noUsing static inline public function lift<T>(self:AccretionApi<T>):Accretion<T> return new Accretion(self);
  
  @:noUsing static public function make<T>(satisfies:SatisfiesApi<T>,data:RedBlackMap<Register,LVar<T>>){
    return lift(new AccretionCls(satisfies,data));
  }
  @:noUsing static public function makeI<T>(satisfies:SatisfiesApi<T>){
    //data:RedBlackMap<Register,LVar<T>>
    final data = RedBlackMap.make(Comparable.Register());
    return lift(new AccretionCls(satisfies,data));
  }
  public function prj():AccretionApi<T> return this;
  private var self(get,never):Accretion<T>;
  private function get_self():Accretion<T> return lift(this);
}
class AccretionLift{
  static public inline function lift<T>(self:AccretionApi<T>):Accretion<T>{
    return Accretion.lift(self);
  }
} 