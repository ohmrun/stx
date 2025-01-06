package stx.parse;

import haxe.Exception;
import stx.nano.Equity.EquityLift;

typedef ParseResultDef<P,R> = EquityDef<ParseInput<P>,Option<R>,ParseFailure>;

@:using(stx.nano.Equity.EquityLift)
@:using(stx.parse.ParseResult.ParseResultLift)
@:forward abstract ParseResult<P,R>(ParseResultDef<P,R>) from ParseResultDef<P,R> to ParseResultDef<P,R>{
  
  public function new(self) this = self;
  @:noUsing static public function lift<P,R>(self:ParseResultDef<P,R>):ParseResult<P,R> return new ParseResult(self);
  @:noUsing static public function make<I,O>(asset:ParseInput<I>,value:Option<O>,error:Error<ParseFailure>):ParseResult<I,O>{
    final def : ParseResultDef<I,O> = new EquityCls(error,value,asset);
    return lift(def);
  }
  @:from static public function fromEquity<P,R>(self:Equity<ParseInput<P>,Option<R>,ParseFailure>):ParseResult<P,R>{
    return make(self.asset,self.value,self.error);
  }
  public inline function map<Ri>(fn:R->Ri):ParseResult<P,Ri>{
    return fromEquity(EquityLift.map(this,opt -> opt.map(fn)));
  }
  public inline function is_ok(){
    return this.error.is_defined() == false;
  }
  public inline function fails<Ri>():ParseResult<P,Ri>{
    return make(this.asset,None,this.error);
  }
  /**
   * Pretend error type `E` is `Dynamic`
   * @return ParseResult<P,Dynamic>
   */
  public function elide():ParseResult<P,Dynamic>{
    return this;
  }
  public function defect(next:Error<ParseFailure>):ParseResult<P,R>{
    return EquityLift.defect(this,next);
  }
  public function prj():ParseResultDef<P,R> return this;
  private var self(get,never):ParseResult<P,R>;
  private function get_self():ParseResult<P,R> return lift(this);

  public inline function pos(){
    return this.asset;
  }
  public function toChunk(){
    return ParseResultLift.toChunk(this);
  }
  // public function errata(fn:Error<ParseFailure>->Error<ParseFailure>):ParseResult<P,R>{
  //   return _.errata(this,fn);
  // }
  public function toUpshot(){
    return ParseResultLift.toUpshot(this);
  }
  /**
   * Error is fatal if any of the Lapses contains a crack.
   * @return `Bool`
   */
  public function is_fatal():Bool{
    return this.error.lapse.toIter().lfold(
      (n:Lapse<ParseFailure>,m:Bool) -> m.if_else(
        () -> true,
        () -> n.crack != null
      ),
      false
    );
  }
}
class ParseResultLift{
  static public function toString<I,O>(self:ParseResult<I,O>):String{
    return self.has_error().if_else(
      () -> Std.string(self.error),
      () -> Std.string(self.value) 
    );
  }
  static public function mkLR<I,T>(seed: ParseResult<I,Dynamic>, rule: Parser<I,T>, head: Option<Head>) : LR return {
    seed: seed,
    rule: rule.elide(),
    head: head
  }
  static public function mod<P,R>(self:ParseResult<P,R>,fn:ParseInput<P> -> ParseInput<P>):ParseResult<P,R>{
    return ParseResult.fromEquity(self.copy(fn(self.asset)));
  }
  static public function flat_map<P,Ri,Rii>(self:ParseResult<P,Ri>,fn:Ri->ParseResult<P,Rii>):ParseResult<P,Rii>{
    return self.is_ok().if_else(
      () -> self.value.fold(
        ok -> fn(ok),
        () -> self.asset.nil()
      ),
      () -> self.fails()
    );   
  }
  static public inline function fudge<P,R>(self:ParseResult<P,R>):R{
    return self.value.fudge();
  }
  static public inline function toUpshot<P,R>(self:ParseResult<P,R>):Upshot<Option<R>,ParseFailure>{
    return switch(self.is_ok()){
      case true   : __.accept(self.value);
      case false  : __.reject(self.toDefect().error);
    };
  }
  static public inline function toChunk<P,R>(self:ParseResult<P,R>):Chunk<R,ParseFailure>{
    return switch(self.is_ok()){
      case true : 
        switch(self.value){
          case Some(x) : Val(x);
          case None    : Tap;
        }
      case false :
        End(self.error);
    }
  }
  static public function errata<P,R>(self:ParseResultDef<P,R>,fn:ParseFailure->ParseFailure):ParseResult<P,R>{
    return ParseResult.make(self.asset,self.value,self.error.errata(fn));
  }
  // static public function errata<I,O>(self:ParseResultDef<I,O>,fn:Error<ParseFailure>->Error<ParseFailure>):ParseResult<I,O>{
  //   return ParseResult.make(self.asset,self.value,self.error.errata(fn));
  // }
}