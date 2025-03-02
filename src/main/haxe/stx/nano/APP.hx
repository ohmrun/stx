package stx.nano;

typedef APPDef<P,R> = Tup2<P -> R,P>;

abstract APP<P,R>(APPDef<P,R>) from APPDef<P,R> to APPDef<P,R>{
  public function new(self) this = self;
  @:noUsing static public function lift<P,R>(self:APPDef<P,R>):APP<P,R> return new APP(self);

  public function prj():APPDef<P,R> return this;
  private var self(get,never):APP<P,R>;
  private function get_self():APP<P,R> return lift(this);

  @:noUsing @:from static public function fromR<P,R>(r:R):APP<P,R>{
    return lift(tuple2((_:P) -> r,null));
  }
  public function reply():R{
    return switch(this){
      case tuple2(f,p) : f(p);
    }
  }
  static public function app<P,R>(self:CTR<P,R>,p:P):APP<P,R>{
    return Tup2.tuple2(self,p);
  }
}