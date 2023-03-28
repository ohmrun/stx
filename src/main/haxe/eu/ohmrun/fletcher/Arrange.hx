package eu.ohmrun.fletcher;


enum ArrangeArgSum<I,S,O,E>{
  ArrangeArgPure(o:O);
  ArrangeArgRes(res:Res<O,E>);
  ArrangeArgFun1Attempt(f:I->Attempt<S,O,E>);
  ArrangeArgFun1Modulate(f:I->Modulate<S,O,E>);
}
abstract ArrangeArg<I,S,O,E>(ArrangeArgSum<I,S,O,E>) from ArrangeArgSum<I,S,O,E>{
  public function new(self) this = self;
  static public function lift<I,S,O,E>(self:ArrangeArgSum<I,S,O,E>):ArrangeArg<I,S,O,E> return new ArrangeArg(self);

  @:from static public function fromArgFun1Modulate<I,S,O,E>(f:I->Modulate<S,O,E>):ArrangeArg<I,S,O,E>{
    return ArrangeArgFun1Modulate(f);
  }
  @:from static public function fromArgFun1Attempt<I,S,O,E>(f:I->Attempt<S,O,E>):ArrangeArg<I,S,O,E>{
    return ArrangeArgFun1Attempt(f);
  }
  @:from static public function fromArgRes<I,S,O,E>(res:Res<O,E>):ArrangeArg<I,S,O,E>{
    return ArrangeArgRes(res);
  }
  @:from static public function fromArgPure<I,S,O,E>(o:O):ArrangeArg<I,S,O,E>{
    return ArrangeArgPure(o);
  }
  public function prj():ArrangeArgSum<I,S,O,E> return this;
  private var self(get,never):ArrangeArg<I,S,O,E>;
  private function get_self():ArrangeArg<I,S,O,E> return lift(this);
}
typedef ArrangeDef<I,S,O,E>             = ModulateDef<Couple<I,S>,O,E>;
@:using(eu.ohmrun.fletcher.Arrange.ArrangeLift)
@:forward abstract Arrange<I,S,O,E>(ArrangeDef<I,S,O,E>) from ArrangeDef<I,S,O,E> to ArrangeDef<I,S,O,E>{
  static public var _(default,never) = ArrangeLift;

  public inline function new(self) this = self;
  @:noUsing static public inline function lift<I,S,O,E>(self:ArrangeDef<I,S,O,E>):Arrange<I,S,O,E>                         
    return new Arrange(self);

  @:noUsing static public inline function bump<I,S,O,E>(self:ArrangeArg<I,S,O,E>):Arrange<I,S,O,E>{
    return switch(self){
      case ArrangeArgPure(o)            : Arrange.pure(o);
      case ArrangeArgRes(res)           : Arrange.fromRes(res);
      case ArrangeArgFun1Attempt(f)     : Arrange.fromFun1Attempt(f);  
      case ArrangeArgFun1Modulate(f)    : Arrange.fromFun1Modulate(f);  
    }
  }
  @:noUsing static public function pure<I,S,O,E>(o:O):Arrange<I,S,O,E>{
    return lift(Fletcher.Anon(
      (i:Res<Couple<I,S>,E>,cont:Terminal<Res<O,E>,Noise>) -> 
        cont.receive(
          i.fold(
            i -> cont.value(__.accept(o)),
            e -> cont.value(__.reject(e))
          )
        )
    ));
  }
  @:noUsing static public function fromRes<I,S,O,E>(res:Res<O,E>):Arrange<I,S,O,E>{
    return lift(Fletcher.Anon(
      (i:Res<Couple<I,S>,E>,cont:Terminal<Res<O,E>,Noise>) -> 
        cont.receive(
          i.fold(
            i -> cont.value(res),
            e -> cont.value(__.reject(e))
          )
        )
    ));
  }
  @:from static public function fromFun1Attempt<I,S,O,E>(f:I->Attempt<S,O,E>):Arrange<I,S,O,E>{
    return lift(Fletcher.Anon(
      (i:Res<Couple<I,S>,E>,cont:Terminal<Res<O,E>,Noise>) -> 
        i.fold(
          i -> cont.receive(f(i.fst()).forward(i.snd())),
          e -> cont.value(__.reject(e)).serve()
        )
    ));
  }
  @:from static public function fromFunResAttempt<I,S,O,E>(f:Res<I,E>->Attempt<S,O,E>):Arrange<Res<I,E>,S,O,E>{
    return lift(Fletcher.Anon(
      (i:Res<Couple<Res<I,E>,S>,E>,cont:Terminal<Res<O,E>,Noise>) -> 
        i.fold(
          i -> cont.receive(f(i.fst()).forward(i.snd())),
          e -> cont.value(__.reject(e)).serve()
        )
    ));
  }
  @:from static public function fromFun1Modulate<I,S,O,E>(f:I->Modulate<S,O,E>):Arrange<I,S,O,E>{
    return lift(Fletcher.Anon(
      (i:Res<Couple<I,S>,E>,cont:Terminal<Res<O,E>,Noise>) -> 
        i.fold(
          i -> cont.receive(f(i.fst()).forward(__.accept(i.snd()))),
          e -> cont.value(__.reject(e)).serve()
        )
    ));
  }
  @:from static public function fromFunResModulate<I,S,O,E>(f:Res<I,E>->Modulate<S,O,E>):Arrange<Res<I,E>,S,O,E>{
    return lift(Fletcher.Anon(
      (i:Res<Couple<Res<I,E>,S>,E>,cont:Terminal<Res<O,E>,Noise>) -> 
        i.fold(
          (i) -> cont.receive(f(i.fst()).forward(__.accept(i.snd()))),
          (e) -> cont.value(__.reject(e)).serve()
        )
    ));
  }
  @:noUsing static public function bind_fold<I,S,E,T>(fn:T->I->Modulate<S,I,E>,iterable:Iterable<T>):Option<Arrange<I,S,I,E>>{
    return iterable
     .toIter()
     .map((t:T) -> (fn.bind1(t):I->Modulate<S,I,E>))
     .map(fromFun1Modulate)
     .lfold1(
       (next:Arrange<I,S,I,E>,memo:Arrange<I,S,I,E>) ->  {
         return Arrange.lift(_.state(memo).then(next.toFletcher()));
       }
     );
   }
   @:from static public function fromFun2R<I,S,O,E>(fn:I->S->O):Arrange<I,S,O,E>{
    return modifier(fn);
   }
   @:noUsing static public function modifier<I,S,O,E>(fn:I->S->O):Arrange<I,S,O,E>{
     return lift(
       Fletcher.Anon(
         (res:Res<Couple<I,S>,E>,cont:Terminal<Res<O,E>,Noise>) -> 
            res.fold( 
              __.decouple((i:I,s:S) -> cont.value(__.accept(fn(i,s))).serve()),
              (e) -> cont.value(__.reject(e)).serve()
          )
       )
     );
   }
   public function split<Oi>(that:Arrange<I,S,Oi,E>):Arrange<I,S,Couple<O,Oi>,E>{
    return _.split(this,that);
   }
   @:to public inline function toFletcher():Fletcher<Res<Couple<I,S>,E>,Res<O,E>,Noise>{
     return this;
   }
   @:to public function toModulate():Modulate<Couple<I,S>,O,E>{
    return this;
  }

}
class ArrangeLift{
  static public function state<I,S,O,E>(self:Arrange<I,S,O,E>):Modulate<Couple<I,S>,Couple<O,S>,E>{
    return Modulate.lift(
      self.broach().map(
      __.decouple(
        (tp:Res<Couple<I,S>,E>,chk:Res<O,E>) -> tp.map(_ -> _.snd()).zip(chk).map(
          (tp) -> tp.swap()
        )
      )
    ));
  }
  static public function attempt<I,S,O,Oi,E>(self:Arrange<I,S,O,E>,attempt:Attempt<O,Oi,E>):Arrange<I,S,Oi,E>{
    return Arrange.lift(
      self.then(
        attempt.toModulate()
      )
    );
  }
  static public function errata<I,S,O,E,EE>(self:Arrange<I,S,O,E>,fn:Refuse<E>->Refuse<EE>):Arrange<I,S,O,EE>{
    return Arrange.lift(
      Fletcher.Anon(
        (res:Res<Couple<I,S>,EE>,cont:Terminal<Res<O,EE>,Noise>) -> res.fold(
          i -> cont.receive(self.map((res:Res<O,E>) -> res.errata(fn)).forward(__.accept(i))),
          e -> cont.value(__.reject(e)).serve()
        )
      )
    );
  }
  static public function errate<I,S,O,E,EE>(self:Arrange<I,S,O,E>,fn:E->EE):Arrange<I,S,O,EE>{
    return Arrange.lift(errata(self,(oc) -> oc.errate(fn)));
  }
  static public function convert<I,S,O,Oi,E>(self:Arrange<I,S,O,E>,that:Convert<O,Oi>):Arrange<I,S,Oi,E>{
    return Arrange.lift(
      Modulate._.convert(self,that)     
    );
  }
  static public function cover<I,S,O,E>(self:Arrange<I,S,O,E>,i:I):Modulate<S,O,E>{
    return Modulate.lift(
      Fletcher.Anon(
        (res:Res<S,E>,cont:Terminal<Res<O,E>,Noise>) ->  
          cont.receive(
            self.forward(res.map(__.couple.bind(i)))
         )
      )
    );
  }
  static public function split<I,S,O,Oi,E>(self:Arrange<I,S,O,E>,that:Arrange<I,S,Oi,E>):Arrange<I,S,Couple<O,Oi>,E>{
    //faffing to make sure error propagates properly
    var a = Fletcher._.broach(self).map(
      ((tp:Couple<Res<Couple<I,S>,E>,Res<O,E>>) -> tp.decouple(
        (resInput:Res<Couple<I,S>,E>,resOutput:Res<O,E>) -> resOutput.flat_map(
          (o:O) -> resInput.map(
            (couple:Couple<I,S>) -> __.triple(couple.fst(),o,couple.snd())
          )
        )
      ))
    );
    var b = Modulate.lift(a.map(
      res -> res.map(tr -> tr.detriple(
        (a,b,c) -> __.couple(a,c)
      ))
    )).modulate(that);
    //$type(a);
    //$type(b);
    var c = Modulate.lift(a.map(
      res -> res.map(tr -> tr.detriple(
        (a,b,c) -> b
      ))
    ));
    //$type(c);
    var d = Arrange.lift(b.split(c).map((tp:Couple<Oi,O>) -> tp.swap()));
    //$type(d);
    return d;
  }
  //static public function arrange<I,S,O,Oi,E>(self:Arrange<I,S,O,E>,that:Arrange<)
}