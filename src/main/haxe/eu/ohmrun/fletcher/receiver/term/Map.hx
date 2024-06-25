package eu.ohmrun.fletcher.receiver.term;

import eu.ohmrun.fletcher.core.ReceiverInput.ReceiverInputLift;

abstract class Map<R,Ri,E> extends Delegate<Receiver<R,E>,Ri,E>{
  public function new(delegate){
    super(delegate);
  }
  abstract public function map(r:R):Ri;

  public function apply(app:Apply<ReceiverInput<Ri,E>,Work>):Work{
    return delegate.apply(
      Apply.Anon(
        (input:ReceiverInput<R,E>) -> {
          final next = ReceiverInputLift.map(input,map);
          return app.apply(next);
        }
      )
    );
  }
}