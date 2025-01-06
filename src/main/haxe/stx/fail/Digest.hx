package stx.fail;


/**
 * Conveniance function for creating `Lapse` instances of indeterminate type.
 */
class DigestCls{
  public function new(uuid:Uuid,message:String,loc:Loc,?canon:Null<Int>){
    this.label  = '$uuid';
    this.crack  = new Exception(message);
    this.loc    = loc;
    this.canon  = canon ?? -1; 
  }  
  public final crack  : Exception;
  public final label  : String;
  public final loc    : Loc; 
  public final canon  : Int; 

  public function toLapse<E>():Lapse<E>{
    return { crack : crack, label : label, loc : loc, canon : canon };
  }
}
@:forward abstract Digest(DigestCls) from DigestCls to DigestCls{
  public function new(self) this = self;
  @:noUsing static public function lift(self:DigestCls):Digest return new Digest(self);
  @:noUsing static public function make(uuid:Uuid,message:String,loc:Loc,?canon):Digest{
    return new DigestCls(uuid,message,loc,canon);
  }
  public function prj():DigestCls return this;
  private var self(get,never):Digest;
  private function get_self():Digest return lift(this);

  @:to public function toLapse<E>():Lapse<E>{
    return this.toLapse();
  }
}