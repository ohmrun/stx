package stx.makro.type;

@:forward abstract HTFunArgArray(Array<HTFunArg>) from Array<HTFunArg>{
  @:noUsing static public function lift(self:Array<HTFunArg>){
    return new HTFunArgArray(self);
  }
  public function new(self) this = self;
  
  @:from static public function fromArray(self:Array<HTFunArg>){
    return lift(self);
  }
} 