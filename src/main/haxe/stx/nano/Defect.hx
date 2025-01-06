package stx.nano;

/**
 * Base of the ambigious state object tree.
 * Returns the unit of Error
 */
typedef DefectDef<E> = {
  /**
   * Possible error related to this object.
   */
  public var error(get,null):Error<E>;
  /**
   * accessor for `error`
   */
  public function get_error():Error<E>;

  @:bug("causes crash in HashLink")
  // public function toDefect():stx.nano.Defect<E>;

  /**
   * Raise an error
   */
  public function crack():Void;
}
@:pure interface DefectApi<E>{
  public var error(get,null):Error<E>;
  public function get_error():Error<E>;
  public function toDefect():Defect<E>;


  public function crack():Void;
}
@:pure class DefectCls<E> implements DefectApi<E>{
  public var error(get,null):Error<E>;
  public function get_error():Error<E>{ 
    return error;
  }
  public function new(error:Error<E>){
    this.error = Option.make(error).def(ErrorCtr.instance.Unit);
  }
  public function toDefect():Defect<E>{
    return this;
  }
  public function crack():Void{
    throw this;
  }
}
@:using(stx.nano.Defect.DefectLift)
@:forward abstract Defect<E>(DefectDef<E>) from DefectDef<E> to DefectDef<E>{
  
  public function new(self:DefectDef<E>){
    this = self;
  }
  @:noUsing static public function lift<E>(self:DefectDef<E>){
    return new Defect(self);
  }
  @:noUsing static public function unit<E>():Defect<E>{
    return lift(new DefectCls(ErrorCtr.instance.Unit()));
  }
  @:noUsing static public function pure<E>(e:E):Defect<E>{
    return make(ErrorCtr.instance.Value(e));
  }
  @:noUsing static public function make<E>(?data:Error<E>){
    return Option.make(data).map((x:Error<E>) -> lift(new DefectCls(x))).def(unit);
  }

  @:from static public function fromError<E>(self:Error<E>):Defect<E>{
    return Defect.make(self);
  }
  public function elide():Defect<Dynamic>{
    return this;
  }
  public function entype<E>():Defect<E>{
    return cast this;
  }
  public function prj():DefectDef<E>{
    return this;
  }
}
class DefectLift{
  static public function concat<E>(self:Defect<E>,that:Defect<E>):Defect<E>{
    return Defect.make(self.error.concat(that.error));
  }
  static public function errata<E,EE>(self:Defect<E>,fn:E->EE):Defect<EE>{
    return Defect.make(self.error.errata(fn));
  }
  static public function blame<E>(self:Defect<E>,?e:Error<E>):Defect<E>{
    var next_error = null;
    if(self.error == null){
      next_error = e;
    }else{
      next_error =  self.error.concat(e);
    }
    return Defect.make(next_error);
  }
  static public function has_error<E>(self:Defect<E>):Bool{
    return self.error.is_defined();
  }
}