package stx.fail;

class ErrorCtr {
  static public var instance(get,null) : stx.fail.ErrorCtr;
  static private function get_instance(){
    return instance == null ? instance = new stx.fail.ErrorCtr() : instance;
  } 
  public function new(){}
  public function Make<E>(lapse:CTR<LapseCtr,List<Lapse<E>>>):Error<E>{
    return Error.make(lapse.apply(new LapseCtr()));
  }
  public function Value<E>(value:E,?loc:CTR<LocCtr,Loc>):Error<E>{
    return Make(ctr -> ctr.Value(value,loc).enlist());
  }
  public function Label<E>(label:String,?loc:CTR<LocCtr,Loc>):Error<E>{
    return Make(ctr -> ctr.Label(label,loc).enlist());
  }
  public function Crack<E>(crack:Exception,?loc:CTR<LocCtr,Loc>):Error<E>{
    return Make(ctr -> ctr.Crack(crack,loc).enlist());
  }
  public function Canon<E>(canon:Int,?loc:CTR<LocCtr,Loc>):Error<E>{
    return Make(ctr -> ctr.Canon(canon,loc).enlist());
  }
  public function Unit<E>():Error<E>{
    return Make(_ -> new List());
  }
  public function Stash<E,EE>(self:Error<E>,stash:Stash<Lapse<E>>):Error<EE>{
    return Make(_ -> self.lapse.map(
      (item) -> {
        final uuid = stash.stash(item);
        return new LapseCtr().Stash(uuid.toString());
      }
    ));
  }
  public function Digest<E>(l : DigestCls):Error<E>{
    final list : List<Lapse<E>> = new List();
    final val : LapseDef<E> = {
      label : l.label,
      loc   : l.loc
    }
          list.add(val);
    return Make(_ -> list);
  }
  public function Ingest<E>(l : Ingest<E>):Error<E>{
    final list  : List<Lapse<E>> = new List();
    final val   : LapseDef<E>    = {
      label : l.label,
      value : l.value
    }
          list.add(val);
    return Make(_ -> list);
  }
}
interface ErrorApi<E>{
  /**
   * List of `Lapse`s
   */
  public final lapse : List<Lapse<E>>;
  public function is_defined():Bool;
  public function iterator():Iterator<Lapse<E>>;
  public function is_fatal():Bool;
  public function asError():Error<E>;
  public function concat(that:Error<E>):Error<E>;
  public function errata<EE>(fn:E->EE):Error<EE>;
  public function crack():Void;
  public function toString():String;
}
class ErrorCls<E> implements ErrorApi<E>{
  public final lapse : List<Lapse<E>>;
  public function new(lapse:List<Lapse<E>>){
    this.lapse = lapse;
  }
  public function is_defined():Bool{
    return !lapse.isEmpty();
  }
  public function iterator(){
    return lapse.iterator();
  }
  public function is_fatal():Bool{
  return Lambda.exists(this.lapse ?? new List(),x -> x.crack != null);
  }
  public function asError():Error<E>{
    return this;
  }
  public function concat(that:Error<E>):Error<E>{
    final lapse = new List();
    for(i in that.lapse){
      lapse.add(i);
    }
    for(i in this.lapse){
      lapse.add(i);
    }
    return new ErrorCls(lapse);
  }
  public function errata<EE>(fn:E->EE):Error<EE>{
    return new ErrorCls(this.lapse.map(x -> x.map(fn)));
  }
  public function toString(){
    return this.lapse.map(x -> x.toString()).join("\n");
  }
  public function crack(){
    throw this;
  }
}
@:forward abstract Error<E>(ErrorApi<E>) from ErrorApi<E> to ErrorApi<E>{
  public function new(self) this = self;
  @:noUsing static public function lift<E>(self:ErrorApi<E>):Error<E> return new Error(self);

  public function prj():ErrorApi<E> return this;
  private var self(get,never):Error<E>;
  private function get_self():Error<E> return lift(this);

  static public function make<E>(self:List<Lapse<E>>):Error<E>{
    return new ErrorCls(self);
  }
  public function usher<Z>(fn:List<Lapse<E>>->Z):Z{
    return fn(this.lapse);
  }
}