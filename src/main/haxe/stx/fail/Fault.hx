package stx.fail;

/**
 * Base type for error building capabilities of the `stx.pico.Wildcard` static extension.
 * ```haxe
 * Fault.make()
 * ```
 */
abstract Fault(Null<Pos>) from Null<Pos>{
  public function new(self) this = self;
  
  static public function make(?pos:Pos){
    return lift(pos);
  }
  /**
   * Lift function for Fault
   * @see https://github.com/ohmrun/docs/blob/main/conventions.md#lift
   * @param self 
   */
  @:stx.code.construct.lift
  @:noUsing static public function lift(self:Null<Pos>){
    return new Fault(self);
  }
  /**
   * Turns any value of type `E` into a `Error<E>`
   * @param fn 
   * @return Error<E>
   */
  inline public function of<E>(data:E):Error<E>{
    final loc : Loc = this;
    return ErrorCtr.instance.Make(_ -> new LapseCtr().Value(data,_ -> loc).enlist());
  }
  inline public function to<E>(fn:CTR<Fault,Error<E>>):Error<E>{
    return fn.apply(this);
  }
  /**
   * Hanger for untyped Errors
   * @param fn `CTR<Ingests<E>`
   * @param CTR<Pos,Error<E>>> ``
   */
  inline public function digest<E>(fn:CTR<Digests,CTR<Pos,Digest>>):Error<E>{
    return ErrorCtr.instance.Make(_ -> fn.apply(__).apply(this).toLapse().enlist());
  }
  /**
   * Hanger for typed Errors
   * @param fn `CTR<Ingests<E>`
   * @param CTR<Pos,Error<E>>> ``
   */
  inline public function ingest<E>(fn:CTR<Ingests<E>,CTR<Loc,Lapse<E>>>):Error<E>{
    return ErrorCtr.instance.Make(_ -> fn.apply(STX).apply(this).enlist());
  }
  inline public function except<E>(fn:CTR<Excepts<E>,Lapse<E>>):Error<E>{
    return ErrorCtr.instance.Make(_ -> fn.apply(STX).enlist());
  }
  public function toPos():Null<Pos>{
    return this;
  }
}
