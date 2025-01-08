package stx.nano;

/**
 * Part of the ambiguous state type tree. 
 */
interface ReceiptApi<T,E> extends stx.nano.Defect.DefectApi<E>{
  final value : Null<T>;
  public function iterator():Iterator<T>;
}
class ReceiptCls<T,E> extends stx.nano.Defect.DefectCls<E> implements ReceiptApi<T,E>{
  public final value : Null<T>;
  public function new(error:Error<E>,value:Null<T>){
    super(error);
    this.value = value;
  }
  public function iterator(){
    var done  = false;
    final test = () -> {
      done = true;
      if(error.is_defined()){
        error.crack();
      }else if(value == null){
        throw 'undefined'; 
      }
    }
    return {
      next : () -> {
        test();
        return value;
      },
      hasNext : () -> {
        if(!done){
          test();
          true;
        }else{
          false;
        }
      }
    }
  }
}
typedef ReceiptDef<T,E> = {
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
  final value : Null<T>;
  public function iterator():Iterator<T>;
  
} 

@:using(stx.nano.Receipt.ReceiptUses)
@:forward abstract Receipt<T,E>(ReceiptDef<T,E>) from ReceiptDef<T,E> to ReceiptDef<T,E>{
  
  public function new(self) this = self;
  @:noUsing static public function lift<T,E>(self:ReceiptDef<T,E>):Receipt<T,E> return new Receipt(self);
  static public function unit<T,E>(){
    return make(null,ErrorCtr.instance.Unit());
  }
  @:noUsing static public function make<T,E>(value:Null<T>,?error:Error<E>){
    return lift(new ReceiptCls(Option.make(error).defv(ErrorCtr.instance.Unit()),value));
  }
  public function prj():ReceiptDef<T,E> return this;
  private var self(get,never):Receipt<T,E>;
  private function get_self():Receipt<T,E> return lift(this);

  @:noUsing static public function fromDefect<T,E>(self:Defect<E>):Receipt<T,E>{
    return make(null,self.error);
  }
  @:noUsing static public function pure<T,E>(self:T):Receipt<T,E>{
    return make(self,ErrorCtr.instance.Unit());
  }
}
class ReceiptUses extends Clazz{
  @:noUsing static public function make(){
    return new ReceiptUses();
  }
  @:noUsing static public function lift<T,E>(self:ReceiptDef<T,E>):Receipt<T,E>{
    return Receipt.lift(self);
  }
  static public function blame<T,E>(self:ReceiptDef<T,E>,error:Null<Error<E>>){
    return Receipt.make(
      self.value,
      self.error == null ? error : self.error.concat(error)
    );
  }
  static public function errata<T,E,EE>(self:ReceiptDef<T,E>,fn:E->EE){
    return Receipt.make(
      self.value,
      self.error.errata(fn)
    );
  }
  static public function copy<T,E>(self:ReceiptDef<T,E>,?value:T,?error:Error<E>){
    return Receipt.make(
      Option.make(value).defv(self.value),
      Option.make(error).defv(self.error)
    );
  }
  static public function map<T,Ti,E>(self:ReceiptDef<T,E>,fn:T->Ti):Receipt<Ti,E>{
    return Receipt.make(
      Option.make(self.value).fold(
        ok -> fn(ok),
        () -> null
      ),
      self.error
    );
  }
  static public function is_defined<T,E>(self:ReceiptDef<T,E>){
    return self.value != null;
  }
  static public function has_errors<T,E>(self:ReceiptDef<T,E>){
    return self.error.is_defined();
  }
  static public function has_error<T,E>(self:ReceiptDef<T,E>){
    return self.error.is_defined();
  }
  static public function has_value<T,E>(self:ReceiptDef<T,E>){
    return self.value != null;
  }
  static public function toUpshot<T,E>(self:Receipt<T,E>):Upshot<T,E>{
    return switch(self.has_errors()){
      case true   : stx.nano.Upshot.UpshotSum.Reject(self.error);
      case false  : stx.nano.Upshot.UpshotSum.Accept(self.value); 
    }
  }
}
