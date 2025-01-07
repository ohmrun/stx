package stx.fail;

/**
 * Possible information regarding an Error, it's source and gestures about upstream interpretation.
 */
typedef LapseDef<E> = {
  /**
   * Typed value 
   */
  public final ?value   : E;
  /**
   * label
   */
  public final ?label   : String;
  /**
   * Underlying exception, if it exists
   */
  public final ?crack   : Exception;  
  /**
   * Error number to pass up to sys, or httpCode
   */
  public final ?canon   : Int;
  /**
   * Captured location.
   */
  public final ?loc     : Loc;
}
class LapseCtr{
  public function new(){}
  public function Make<E>(?value,?label,?crack,?canon,?loc):Lapse<E>{
    return Lapse.make(value,label,crack,canon,loc);
  }
  public function Loc<E>(loc:CTR<LocCtr,Loc>):Lapse<E>{
    return Make(null,null,null,null,loc.apply(new LocCtr()));
  }
  public function Label<E>(self:String,?loc:CTR<LocCtr,Loc>):Lapse<E>{
    final loc = if(loc!=null){
      loc.apply(new LocCtr());
    }else{ null; }
    return Make(null,self,null,null,loc);
  }
  public function Value<E>(self:E,?loc:CTR<LocCtr,Loc>):Lapse<E>{
    final loc = if(loc!=null){
      loc.apply(new LocCtr());
    }else{ null; }
    return Make(self,null,null,null,loc);
  }
  public function Crack<E>(self:Exception,?loc:CTR<LocCtr,Loc>):Lapse<E>{
    final loc = if(loc!=null){
      loc.apply(new LocCtr());
    }else{ null; }
    return Make(null,null,self,null,loc);
  }
  public function Canon<E>(self:Int,?loc:CTR<LocCtr,Loc>):Lapse<E>{
    final loc = if(loc!=null){
      loc.apply(new LocCtr());
    }else{ null; }
    return Make(null,null,null,self,loc);
  }
  public function Digest<E>(uuid:String,message:String,code:Null<Int>=-1,?loc:CTR<LocCtr,Loc>):Lapse<E>{
    final loc = if(loc!=null){
      loc.apply(new LocCtr());
    }else{ null; }
    return Make(null,'ERROR $uuid \n$message',null,code,loc);
  }
  public function Stash<E>(uuid){
    return Make(null,uuid,null,500);
  }
  public inline function Embed<E>(self:Void->Void):Lapse<E>{
    return Make(null,null,new EmbedTypedErrorException(self));
  }
  public inline function StashEmptyFor(uuid:String){
    return new LapseCtr().Digest("4071e192-c82e-4c1e-9dc1-e4bdcb471072",'No stash found at $uuid',500);
  }
}
@:forward abstract Lapse<E>(LapseDef<E>) from LapseDef<E> to LapseDef<E>{
  public function new(self) this = self;
  @:noUsing static public function lift<E>(self:LapseDef<E>):Lapse<E> return new Lapse(self);

  @:noUsing static public function make<E>(?value,?label,?crack,?canon,?loc):Lapse<E>{
    return switch([value,label,crack,canon,loc]){
      case [x,null,null,null,null]            : { value : value };
      case [null,x,null,null,null]            : { label : label };
      case [null,null,x,null,null]            : { crack : crack };
      case [null,null,null,x,null]            : { canon : canon };
      case [null,null,null,null,y]            : { loc : loc };
      case [x,null,null,null,y]               : { value : value, loc : loc };
      case [null,x,null,null,y]               : { label : label, loc : loc };
      case [null,null,x,null,y]               : { crack : crack, loc : loc };
      case [null,null,null,x,y]               : { canon : canon, loc : loc };
      default                                 : { value : value, label : label, crack : crack, canon : canon, loc : loc}
    }
  }
  static public function label<E>(self:String,?loc:Loc):Lapse<E>{
    return make(null,self,null,null,loc);
  }
  static public function value<E>(self:E,?loc:Loc):Lapse<E>{
    return make(self,null,null,null,loc);
  }
  static public function crack<E>(self:Exception,?loc:Loc):Lapse<E>{
    return make(null,null,self,null,loc);
  }
  static public function canon<E>(self:Int,?loc:Loc):Lapse<E>{
    return make(null,null,null,self,loc);
  }
  public function prj():LapseDef<E> return this;
  private var self(get,never):Lapse<E>;
  private function get_self():Lapse<E> return lift(this);

  /**
   * `map` the typed value `T`, if it is defined.
   * @param self `Error<E>`
   * @return `Error<Dynamic>`
   */
  public function map<EE>(fn:E->EE):Lapse<EE>{
    return make(this.value == null ? null : fn(this.value),this.label,this.crack,this.canon,this.loc);
  }
  public function toString(){
    final messages = [];

    if(this.canon!=null){
      messages.push('${this.canon}');
    }
    if(this.loc!=null){
      messages.push('${this.loc.toString()}');
    }
    if(this.label!=null){
      messages.push('${this.label}');
    }
    if(this.value!=null){
      messages.push('${this.value}');
    }
    if(this.crack!=null){
      messages.push(this.crack.message);
    }
    final result = messages.join(" ");
    return 'Lapse($result)';
  }
  static public function enlist<E>(self:Lapse<E>):List<Lapse<E>>{
    final list = new List();
          list.add(self);
    return list;
  }
  static public function elide<E>(self:Error<E>):Error<Dynamic>{
    return self.errata(function(e:E):Dynamic{ return e;});
  }
}