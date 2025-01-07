package stx.fail;

class IngestCls<E>{
  @:noUsing static public function make<E>(value:E,label:String,loc:Loc){
    return new IngestCls(value,label,loc);
  }
  public function new(value:E,label:String,loc:Loc){
    this.value  = value;
    this.label  = label;
    this.loc    = loc;
  }  
  public final value  : E;
  public final label  : String;
  public final loc    : Loc;  
}
@:forward abstract Ingest<E>(LapseDef<E>) from LapseDef<E> to LapseDef<E> to Lapse<E>{
  public function new(self) this = self;
  @:noUsing static public function lift<E>(self:LapseDef<E>):Ingest<E> return new Ingest(self);
  @:noUsing static public function make<E>(value:E,label:String,loc:Loc){
    return lift({value:value,label:label,loc:loc});
  }
  public function prj():LapseDef<E> return this;
  private var self(get,never):Ingest<E>;
  private function get_self():Ingest<E> return lift(this);

  static public function fromIngestCls<E>(self:IngestCls<E>):Ingest<E>{
    return lift({value : self.value, label : self.label, loc : self.loc});
  }
}