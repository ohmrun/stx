package stx.nano;

@:using(stx.nano.Report.ReportLift)
abstract Report<E>(ReportSum<E>) from ReportSum<E> to ReportSum<E>{
  
  public function new(self) this = self;
  @:noUsing static public inline function lift<E>(self:ReportSum<E>):Report<E> return new Report(self);

  @:noUsing static public function make<E>(?self:Error<E>):Report<E>{
    return self == null ? unit() : pure(self);
  }
  @:noUsing static public function make0<E>(data:Error<E>):Report<E>{
    return pure(data);
  }
  @:noUsing static public function unit<E>():Report<E>{
    return lift(ReportSum.Happened);
  }
  @:noUsing static public function conf<E>(?e:Error<E>):Report<E>{
    return lift(Option.make(e).map(Reported).defv(ReportSum.Happened));
  }
  @:noUsing static public function pure<E>(e:Error<E>):Report<E>{
    return lift(ReportSum.Reported(e));
  }
  public function iterator(){
    return option().iterator();
  }
  public function effects(success:Void->Void,failure:Void->Void):Report<E>{
    return ReportLift.fold(
      this,
      (e) -> {
        failure();
        return pure(e);
      },
      () -> {
        success();
        return unit();
      }
    );
  }
  public inline function crunch(){
    switch(this){
      case ReportSum.Reported(e)    : throw e;
      default             :
    }
  }
  @:from static public function fromStdOption<E>(opt:haxe.ds.Option<Error<E>>):Report<E>{
    return lift(opt.fold(
      ReportSum.Reported,
      () -> ReportSum.Happened
    ));
  }
  @:from static public function fromOption<E>(opt:Option<Error<E>>):Report<E>{
    return lift(opt.fold(
      ReportSum.Reported,
      () -> ReportSum.Happened
    ));
  } 
  public function prj():ReportSum<E>{
    return this;
  }
  public function option():Option<Error<E>>{
    return ReportLift.fold(
      this,
      (err) -> Some(err),
      () -> None
    );
  }
  public function defv(error:Error<E>){
    return this.defv(error);
  }
  public function or(that:Void->Report<E>):Report<E>{
    return ReportLift.fold(
      this,
      (x) -> Report.pure(x),
      that
    );
  }
  @:note("error in js")
  public function errata<EE>(fn:E->EE):Report<EE>{
    return new Report(
      switch(this){
        case ReportSum.Reported(v) :  ReportSum.Reported(v.errata(fn));
        case ReportSum.Happened    :  ReportSum.Happened;
      }
    );
  }
  public function is_ok(){
    return switch(this){
      case ReportSum.Happened : true;
      default       : false;
    }
  }
  public function promote():Upshot<Nada,E>{
    return ReportLift.resolve(this,() -> Nada);
  }
  public function alert():Alert<E>{
    return Alert.make(this);
  }
}
class ReportLift{
  static function lift<T>(self:ReportSum<T>):Report<T>{
    return Report.lift(self);
  }
  static public function resolve<T,E>(self:ReportSum<E>,fn:Void->T):Upshot<T,E>{
    return fold(
      self,
      (x) -> UpshotSum.Reject(x),
      ()  -> UpshotSum.Accept(fn())
    );
  }
  static public function concat<E>(self:Report<E>,that:Report<E>):Report<E>{
    return switch([self,that]){
      case [ReportSum.Reported(l),ReportSum.Happened]     : ReportSum.Reported(l);
      case [ReportSum.Happened,ReportSum.Reported(r)]     : ReportSum.Reported(r); 
      case [ReportSum.Reported(l),ReportSum.Reported(r)]  : ReportSum.Reported(l.concat(r));
      default                         : ReportSum.Happened;
    }
  }
  static inline public function fold<T,Z>(self:ReportSum<T>,val:Error<T>->Z,nil:Void->Z):Z{
    return switch(self){
      case ReportSum.Reported(v)  : val(v);
      case ReportSum.Happened     : nil();
      case null         : nil();
    }
  }
  static public function def<T>(self:ReportSum<T>,fn:Void->Error<T>):Error<T>{
    return fold(
      self,
      (x) -> x,
      fn
    );
  }
  static public inline function defv<T>(self:ReportSum<T>,v:Error<T>):Error<T>{
    return def(
      self,
      () -> v
    );
  }
  static public function is_defined<T>(self:ReportSum<T>){
    return fold(
      self,
      (_) -> true,
      () -> false
    );
  }
  static public function ignore<T>(self:ReportSum<T>,?fn:Lapse<T>->Bool){
    Option.make(fn).def(() -> fn = (x) -> true);
    return fold(
      self,
      (err:Error<T>) -> {
        final lapses = err.lapse.filter(fn);
        return if(lapses.length == 0){
          Report.make();
        }else{
          Report.make(ErrorCtr.instance.Make(_ -> lapses));
        }
      },
      () -> Report.make()
    );
  }
  //TODO naming issue here
  static public function so<T>(self:ReportSum<T>,fn:Void->Report<T>):Report<T>{
    return fold(
      self,
      e   -> ReportSum.Reported(e),
      ()  -> fn()
    );
  }
  @:deprecated
  static public function and<T>(self:ReportSum<T>,fn:Void->Report<T>):Report<T>{
    return fold(
      self,
      e   -> ReportSum.Reported(e),
      ()  -> fn()
    );
  }
  static public function usher<T,Z>(self:ReportSum<T>,fn:List<Lapse<T>>->Z):Z{
    return switch(self){
      case ReportSum.Reported(refuse)     : refuse.usher(fn);
      default                   : fn(new List());
    }
  }
  static public function crack<T>(self:ReportSum<T>):Void{
    fold(
      self,
      e   -> e.crack(),
      ()  -> {} 
    );
  }
}