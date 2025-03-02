package stx.pico;

/**
 * Interface oriented function application type
 * @see [suffixes](https://github.com/ohmrun/docs/blob/main/conventions.md#suffixes)
 * @see [naming](https://github.com/ohmrun/docs/blob/main/conventions.md#function-naming-conventions)
 */
interface ApplyApi<P,R>{
  /**
   * 
   * @param p
   * @return R
   */
  public function apply(p:P):R;

  /**
   * @see [fluent-interfaces](https://github.com/ohmrun/docs/blob/main/fluent-interfaces.md#fluent-interfaces)
   * For type normalization.
   * @return Apply<P,R>
   */
  public function toApply():Apply<P,R>;
}
/**
 * `Class` oriented function type.
 * @see [suffixes](https://github.com/ohmrun/docs/blob/main/conventions.md#suffixes)
 * @see [naming](https://github.com/ohmrun/docs/blob/main/conventions.md#function-naming-conventions)
 */
abstract class ApplyCls<P,R> implements ApplyApi<P,R>{
  abstract public function apply(p:P):R;
  public function toApply():Apply<P,R>{
    return this;
  }
}
/**
 * Abstract wrapper for `ApplyApi`
 */
@:using(stx.pico.Apply.ApplyLift)
@:forward abstract Apply<P,R>(ApplyApi<P,R>) from ApplyApi<P,R> to ApplyApi<P,R>{
  static public var __(default,never) = ApplyLift;
  public function new(self) this = self;
  static public inline function lift<P,R>(self:ApplyApi<P,R>):Apply<P,R> return new Apply(self);

  @:noUsing static public inline function Anon<P,R>(self:P->R):Apply<P,R>{
    return lift(new stx.pico.apply.term.Anon(self));
  }
  /**
   * [projection](https://github.com/ohmrun/docs/blob/main/conventions.md#prj)
   * 
   * @return ApplyApi<P,R> return this
   */
  @:dox(hide)
  public function prj():ApplyApi<P,R> return this;

  /**
   * [self](https://github.com/ohmrun/docs/blob/main/conventions.md#self)
   */
  @:dox(hide)
  private var self(get,never):Apply<P,R>;
  @:dox(hide)
  private function get_self():Apply<P,R> return lift(this);

  @:noUsing static public function Map<P,R,Ri>(self:Apply<P,R>,fn:R->Ri):Apply<P,Ri>{
    return lift(new stx.pico.apply.term.AnonMap(self,fn));
  }
}
/**
 * 
 */
class ApplyLift{
  @:dox(hide)
  @:noCompletion
  @:noUsing static public function lift<P,R>(self:ApplyApi<P,R>):Apply<P,R>{
    return Apply.lift(self);
  }
  static public function map<P,R,Ri>(self:ApplyApi<P,R>,fn:R->Ri):Apply<P,Ri>{
    return Apply.Map(self,fn);
  }
}