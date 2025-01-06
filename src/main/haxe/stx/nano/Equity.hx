package stx.nano;

/**
 * Api for `stx.nano.Equity`
 */
interface EquityApi<I,O,E> extends stx.nano.Receipt.ReceiptApi<O,E>{
  public final asset : I;
  public function toEquity():EquityDef<I,O,E>;
}
/**
 * Cls for `stx.nano.Equity`
 */
class EquityCls<I,O,E> extends stx.nano.Receipt.ReceiptCls<O,E> implements EquityApi<I,O,E> {
  public final asset : I;
  public function new(error:Error<E>,value:Null<O>,asset:I){
    super(error,value);
    this.asset = asset;
  }
  public function toEquity():EquityDef<I,O,E>{
    return this;
  }
}
/**
 * Def for `stx.nano.Equity`
 */
typedef EquityDef<I,O,E> = {
  // > stx.nano.Receipt.ReceiptDef<O,E>,
  
  //-------------------------------------------------------
  /**
   * Possible error related to this object.
   */
   public var error(get,null):Error<E>;
   /**
    * accessor for `error`
    */
   public function get_error():Error<E>;
 
   public function toDefect():Defect<E>;
 
   /**
    * The value, if exists.
    */
   final value : Null<O>;
   public function iterator():Iterator<O>;
  //-------------------------------------------------------

  /**
   * The value used as the basis for the receipt value.
   */
  final asset : I;

  // public function toEquity():EquityDef<I,O,E>;
} 
/**
 * Represents a value containing some prior value: `asset`, 
 * some possible computed value: `value` (from `Receipt`), 
 * and some possible error `error` (from `Defect`)
 */
@:using(stx.nano.Equity.EquityLift)
@:forward abstract Equity<I,O,E>(EquityDef<I,O,E>) from EquityDef<I,O,E> to EquityDef<I,O,E>{
  
  public function new(self) this = self;
  /**
   * @see https://github.com/ohmrun/docs/blob/main/conventions.md#lift
   * @param self 
   * @param fn 
   * @return Equity<I,O,EE>
   */
  @:noUsing static public function lift<I,O,E>(self:EquityDef<I,O,E>):Equity<I,O,E> return new Equity(self);

  /**
   * @see https://github.com/ohmrun/docs/blob/main/conventions.md#prj
   * @return EquityDef<I,O,E> return this
   */
  public function prj():EquityDef<I,O,E> return this;

  /**
   * @see https://github.com/ohmrun/docs/blob/main/conventions.md#self
   */
  private var self(get,never):Equity<I,O,E>;
  private function get_self():Equity<I,O,E> return lift(this);

  @:noUsing static public function make<I,O,E>(asset:I,value:Null<O>,?error:Error<E>){
    return lift(new EquityCls(error,value,asset).toEquity());
  }
}
class EquityLift extends Clazz{
  @:noUsing static public function make(){
    return new EquityLift();
  }
  @:noUsing static public function lift<I,O,E>(self:EquityDef<I,O,E>):Equity<I,O,E>{
    return Equity.lift(self);
  }
  static public function blame<I,O,E>(self:EquityDef<I,O,E>,?error:Null<Error<E>>){
    return Equity.make(
      self.asset,
      self.value,
      self.error == null ? error : self.error.concat(error)
    );
  }
  static public function errata<I,O,E,EE>(self:EquityDef<I,O,E>,fn:E->EE):Equity<I,O,EE>{
    return Equity.make(
      self.asset,
      self.value,
      (self.error == null ? null : self.error.errata(fn))
    );
  }
  static public function copy<I,O,E>(self:EquityDef<I,O,E>,asset:I,?value:O,?error:Error<E>){
    return lift(new EquityCls(
      Option.make(error).defv(self.error),
      Option.make(value).defv(self.value),
      Option.make(asset).defv(self.asset)
    ).toEquity());
  }
  static public function map<I,O,Oi,E>(self:EquityDef<I,O,E>,fn:O->Oi):Equity<I,Oi,E>{
    return Equity.make(
        self.asset,
      Option.make(self.value).fold(
        ok -> fn(ok),
        () -> null
      ),
      self.error
    );
  }
  static public function mapi<I,Ii,O,E>(self:EquityDef<I,O,E>,fn:I->Ii):Equity<Ii,O,E>{
    return Equity.make(
      fn(self.asset),
      self.value,
      self.error
    );
  }
  static public function is_defined<I,O,E>(self:EquityDef<I,O,E>){
    return self.value != null;
  }
  static public function has_error<I,O,E>(self:EquityDef<I,O,E>){
    return self.error.is_defined();
  }
  static public function has_value<I,O,E>(self:EquityDef<I,O,E>){
    return self.value != null;
  }
  static public function has_asset<I,O,E>(self:EquityDef<I,O,E>){
    return self.asset != null;
  }
  static public function is_ok<I,O,E>(self:EquityDef<I,O,E>){
    return !self.error.is_defined();
  }
  
  /**
   * Returns equity with either
   * 1) If no error, the `error` parameter
   * 2) If errors exists, the previous error and the `error` parameter concatenated
   * @param self 
   * @return Chunk<O,E>
   */
  static public function defect<I,O,E>(self:EquityDef<I,O,E>,error:Error<E>):Equity<I,O,E>{
    return copy(self,null,null,self.error.concat(error));
  }
  static public function relate<I,O,E>(self:EquityDef<I,O,E>,value:O):Equity<I,O,E>{
    return if(lift(self).has_error()){
      self;
    }else{
      copy(self,null,value);
    }
  }
  static public function clear<P,Ri,Rii,E>(self:EquityDef<P,Ri,E>):Equity<P,Rii,E>{
    return Equity.make(self.asset,null,self.error);
  }
  static public function refuse<P,R,E>(self:EquityDef<P,R,E>,error:Error<E>):Equity<P,R,E>{
    return Equity.make(self.asset,self.value,self.error.concat(error));
  }
  static public function defuse<P,R,E,EE>(self:EquityDef<P,R,E>):Equity<P,R,EE>{
    return Equity.make(self.asset,self.value,ErrorCtr.instance.Unit());
  }

  static public inline function toChunk<I,O,E>(self:EquityDef<I,O,E>):Chunk<O,E>{
    return switch(has_value(self)){
      case true    : Chunk.ChunkSum.Val(self.value); 
      case false   : switch(has_error(self)){
        case true   : Chunk.ChunkSum.End(self.error);
        case false  : Chunk.ChunkSum.Tap;
      } 
    }
  }
  static public function rebase<P,Oi,Oii,E>(self:EquityDef<P,Oi,E>,chunk:Chunk<Oii,E>):Equity<P,Oii,E>{
    return switch(chunk){
      case Chunk.ChunkSum.Val(oII) : relate(clear(self),oII);
      case Chunk.ChunkSum.End(e)   : refuse(clear(self),e);
      case Chunk.ChunkSum.Tap      : clear(self);
    }
  }
  static public function adjust<P,Oi,Oii,E>(self:EquityDef<P,Oi,E>,fn:Oi->Upshot<Oii,E>):Equity<P,Oii,E>{
    return if(lift(self).has_value()){
      fn(self.value).fold(
        ok -> lift(self).clear().relate(ok),
        er -> lift(self).clear().refuse(er)
      );
    }else{ 
      lift(self).clear();
    };
  }
  // static public function zip<P,Oi,Oii,E>(self:EquityDef<P,Oi,E>,that:EquityDef<P,Oii,E>):Equity<P,Couple<Oi,Oii>,E>{
  //   return if(self.has_errors() || that.has_errors()){
  //     Equity.make()
  //   }
  // }
}