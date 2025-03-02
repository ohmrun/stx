package eu.ohmrun.fletcher;
        
typedef ResolveDef<I,E> = FletcherDef<Error<E>,Chunk<I,E>,Nada>;

/**
  Chunk.Tap signifies no resolution has been found.
**/
@:using(eu.ohmrun.fletcher.Resolve.ResolveLift)
abstract Resolve<I,E>(ResolveDef<I,E>) from ResolveDef<I,E> to ResolveDef<I,E>{
  public inline function new(self) this = self;
  static public inline function lift<I,E>(self:ResolveDef<I,E>):Resolve<I,E> return new Resolve(self);
  
  @:from static public function fromResolvePropose<I,E>(self:Fletcher<Error<E>,Propose<I,E>,Nada>):Resolve<I,E>{
    return lift(
      self.then(
        Fletcher.Anon((i:Propose<I,E>,cont:Terminal<Chunk<I,E>,Nada>) -> cont.receive(
          i.forward(Nada)
        ))
      )
    );
  }
  @:from static public function fromFunErrPropose<I,E>(arw:Error<E>->Propose<I,E>):Resolve<I,E>{
    return lift(
      Fletcher.Then(
        Fletcher.Sync(arw),
        Fletcher.Anon((i:Propose<I,E>,cont:Terminal<Chunk<I,E>,Nada>) -> cont.receive(
          i.forward(Nada) 
        ))
      )
    );
  }
  @:from static public function fromErrChunk<I,E>(fn:Error<E>->Chunk<I,E>):Resolve<I,E>{
    return lift(Fletcher.Sync(fn));
  }
  @:noUsing static public function unit<I,E>():Resolve<I,E>{
    return lift(Fletcher.Sync((e:Error<E>) -> Tap));
  }

  public function prj():ResolveDef<I,E> return this;
  private var self(get,never):Resolve<I,E>;
  private function get_self():Resolve<I,E> return lift(this);
  @:to public inline function toFletcher():Fletcher<Error<E>,Chunk<I,E>,Nada>{
    return this;
  }
}
class ResolveLift{
  static public function toModulate<I,E>(self:Resolve<I,E>):Modulate<I,I,E>{
    return Modulate.lift(
      Fletcher.Anon((i:Upshot<I,E>,cont:Terminal<Upshot<I,E>,Nada>) -> 
          i.fold(
            (s) -> cont.value(__.accept(s)).serve(),
            (e) -> {
              var next = FletcherLift.map(self,
                (chk:Chunk<I,E>) -> chk.fold(
                  (i) -> __.accept(i),
                  (e) -> __.reject(e),
                  ()  -> __.reject(e)//<-----
                )               
              );
              return cont.receive(next.forward(e));
            }
          )
    ));
  }
}