package stx.log.core;

//> StringCtrDef<T>;
typedef EntryDef<T> = {
  public function ctr(t:T):String;
  public var val : T;
} 

abstract Entry<T>(EntryDef<T>) from EntryDef<T> to EntryDef<T>{
  public function new(self:EntryDef<T>) this = self;
  @:from static public function fromString(str:String){
    return new Entry({ ctr : (_:String) -> str, val : null });
  }
  public function toString():String{
    return this.ctr(this.val);
  }
  public function toValue(source:LogPosition){
    return Value.makeI(this,source);
  }
}