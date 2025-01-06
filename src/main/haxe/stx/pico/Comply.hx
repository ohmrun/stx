package stx.pico;

/**
 * 2 arity function ```Pi -> Pii -> R``` as an Interface
 */
interface ComplyApi<Pi,Pii,R>{
  public function comply(pI:Pi,pII:Pii):R;
  public function toComply():Comply<Pi,Pii,R>; 
}
/**
 * 2 arity function ```Pi -> Pii -> R``` as a Class
 */
abstract class ComplyCls<Pi,Pii,R> implements ComplyApi<Pi,Pii,R> extends Clazz{
  abstract public function comply(pI:Pi,pII:Pii):R;
  public function toComply():Comply<Pi,Pii,R>{
    return this;
  }
}
/**
 * 2 arity function ```Pi -> Pii -> R``` as an Abstract Type
 */
@:using(stx.pico.Comply.ComplyLift)
@:forward abstract Comply<Pi,Pii,R>(ComplyApi<Pi,Pii,R>) from ComplyApi<Pi,Pii,R> to ComplyApi<Pi,Pii,R>{
  static public var __(default,never) = ComplyLift;
  public function new(self) this = self;
  static public inline function lift<Pi,Pii,R>(self:ComplyApi<Pi,Pii,R>):Comply<Pi,Pii,R> return new Comply(self);

  // @:noUsing static public inline function Anon<Pi,Pii,R>(self:Pi->Pii->R):Comply<Pi,Pii,R>{
  //   return lift(new stx.pico.comply.term.Anon(self));
  // }
  public function prj():ComplyApi<Pi,Pii,R> return this;
  private var self(get,never):Comply<Pi,Pii,R>;
  private function get_self():Comply<Pi,Pii,R> return lift(this);

  // @:noUsing static public function Map<Pi,Pii,R,Ri>(self:Comply<Pi,Pii,R>,fn:R->Ri):Comply<Pi,Pii,Ri>{
  //   return lift(new stx.pico.comply.term.AnonMap(self,fn));
  // }
}
class ComplyLift{

}