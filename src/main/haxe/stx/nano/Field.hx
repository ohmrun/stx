package stx.nano;

import stx.nano.KV.KVDef;
import stx.alias.StdString;

@:using(stx.nano.KV.KVLift)
@:forward abstract Field<V>(KVDef<StdString,V>) from KVDef<StdString,V> to KVDef<StdString,V>{
  public function new(self:KVDef<StdString,V>) this = self;
  @:noUsing static public function lift<V>(self:KVDef<std.String,V>):Field<V>{

    return new Field(self);
  }
  @:noUsing @:from static public function fromTup<V>(tp:Couple<StdString,V>):Field<V>{
    return new Field({ key : tp.fst(), val : tp.snd()});
  }
  @:noUsing @:from static public function fromCouple<V>(tp:Couple<StdString,V>):Field<V>{
    return new Field({ key : tp.fst(), val : tp.snd()});
  }
  @:noUsing static public function make<V>(key:StdString,val:V){
    return new Field({
      key : key,
      val : val
    });
  }
  public function map<U>(fn:V->U):Field<U>{
    return Field.lift(KV.lift(this).map(fn));
  }
  public function into<R>(fn:StdString->V->R):R{
    return fn(this.key,this.val);
  }
  public function toCouple():Couple<StdString,V>{
    return Couple.make(this.key,this.val);
  }
  @:from static public function fromKeyValue<V>(self:{key:String,value:V}){
    return lift({
      key : self.key,
      val : self.value
    });   
  }
  public var value(get,never) : V;
  public function get_value(){
    return this.val;
  }
}