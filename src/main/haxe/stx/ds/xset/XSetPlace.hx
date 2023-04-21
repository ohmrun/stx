package stx.ds.xset;

enum XSetPlaceSum{
  Field(idx:Int,key:String);
  Index(idx:Int);
}

@:forward abstract XSetPlace(XSetPlaceSum) from XSetPlaceSum to XSetPlaceSum{
  @:noUsing static public function lift(self:XSetPlaceSum){
    return new XSetPlace(self);
  }
  public function new(self:XSetPlaceSum){
    this = self;
  }
  public function index(){
    return switch(this){
      case Field(idx, _)   : idx;
      case Index(idx)      : idx;
    }
  }
  public function field(){
    return switch(this){
      case Field(_,key):key;
      default : null;
    }
  }
  @:from static public function fromString(string:String){
    return lift(Field(stx.ds.xset.tree.Counter.instance.next(),string));
  }  
  @:from static public function fromIndex(idx:Int){
    return lift(Index(idx));
  }
  public function has_key(str:String){
    return __.option(field()).map(x -> x == str).defv(false);
  }
  public function fold<Z>(field:Int->String->Z,index:Int->Z):Z{
    return switch(this){
      case Field(i,k) : field(i,k);
      case Index(i)   : index(i);
    }
  }
}